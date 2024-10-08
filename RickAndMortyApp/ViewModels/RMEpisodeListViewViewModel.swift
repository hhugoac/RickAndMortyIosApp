//
//  RMEpisodeListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 20/09/24.
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisode(with newIndexPaths: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}

/// ViewModel to handle episode items and populate the lists
final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    private var isLoadingMoreCharacters: Bool = false
    
    private let borderColors: [UIColor] = [
        .systemRed,
        .systemGreen,
        .systemBlue,
        .systemOrange,
        .systemPink,
        .systemPurple,
        .systemRed,
        .systemYellow,
        .systemIndigo,
        .systemMint,
    ]
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes {
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(
                    episodeDataUrl:URL(string: episode.url),
                    borderColor: borderColors.randomElement() ?? .systemBlue
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    
    /// Fetch initial set of episodes (20)
    public func fetchListEpisodes() {
        RMService.shared.execute(
            .listEpisodesRequest,
            expecting: RMGetAllEpisodesResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.episodes = results
                self?.apiInfo = responseModel.info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print("FAILURE: " + String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalEpisodes(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }

        isLoadingMoreCharacters = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                //This issue causes that tha list append more items into the list, because in line 91 there was othe append and this affected the count and the aray append with more chars
                //that required
                //strongSelf.characters.append(contentsOf: moreResults)
                strongSelf.apiInfo = info

                let originalCount = strongSelf.episodes.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.episodes.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreEpisode(
                        with: indexPathsToAdd
                    )
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let error):
                print(String(describing: error))
                self?.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldShowMoreIndecator: Bool {
        return apiInfo?.next != nil
    }
}

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, shouldShowMoreIndecator, let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? RMFooterLoadingCollectionReusableView  else {
            fatalError("Unsupported view")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowMoreIndecator else {
            return .zero
        }
        
        return CGSize(
            width: collectionView.frame.width,
            height: 100
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = bounds.width - 20
        return CGSize(
            width: width,
            height: 100
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        delegate?.didSelectEpisode(episode)
    }
}

extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowMoreIndecator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let next = apiInfo?.next,
              let url = URL(string: next)
        else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewHeight = scrollView.frame.size.height
            
            if  offset >= (totalContentHeight - totalScrollViewHeight - 120) {
                self?.fetchAdditionalEpisodes(url: url)
            }
            t.invalidate()
        }
    }
}

