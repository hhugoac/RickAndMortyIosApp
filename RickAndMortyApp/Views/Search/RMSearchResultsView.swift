//
//  RMSearchResultsView.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 07/10/24.
//

import UIKit

protocol RMSearchResultsViewDelegate: AnyObject {
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapLocationAt index: Int)
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapCharacterAt index: Int)
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapEpisodeAt index: Int)
}

final class RMSearchResultsView: UIView {

    weak var delegate: RMSearchResultsViewDelegate?

    private var viewModel: RMSearchResultViewModel? {
        didSet {
            self.processViewModel()
        }
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            RMLocationTableViewCell.self,
            forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            RMCharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterCollectionViewCell
                .collectionIdentifier)
        collectionView.register(
            RMCharacterEpisodeCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell
                .cellIdentifier)
        collectionView.register(
            RMFooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView
                .elementKindSectionFooter,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView
                .identifier)

        return collectionView
    }()

    private var locationCellViewModels: [RMLocationTableViewCellViewModel] = []
    private var collectionViewModelCellViewModels: [any Hashable] = []

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, collectionView)
        addCobstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("unsupported initializer")
    }
    private func processViewModel() {
        guard let viewModel = viewModel else { return }
        switch viewModel.results {
        case .characters(let viewModels):
            self.collectionViewModelCellViewModels = viewModels
            setUpCollectionView()
        case .episodes(let viewModels):
            self.collectionViewModelCellViewModels = viewModels
            setUpCollectionView()
        case .locations(let viewModels):
            setUpTableView(viewModels: viewModels)

        }
    }

    private func setUpCollectionView() {
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    private func setUpTableView(viewModels: [RMLocationTableViewCellViewModel])
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.isHidden = false
        collectionView.isHidden = true
        self.locationCellViewModels = viewModels
        tableView.reloadData()
    }
    private func addCobstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        tableView.backgroundColor = .yellow
    }

    public func configure(with viewModel: RMSearchResultViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: -  TableView

extension RMSearchResultsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return locationCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RMLocationTableViewCell.cellIdentifier,
                for: indexPath) as? RMLocationTableViewCell
        else {
            fatalError("Could not dequeue cell")
        }
        cell.configure(with: locationCellViewModels[indexPath.row])
        return cell
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.rmSearchResultsView(self, didTapLocationAt: indexPath.row)
    }
}

// MARK: - ColectionView

extension RMSearchResultsView: UICollectionViewDataSource,
    UICollectionViewDelegate
{
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let currentViewModel = collectionViewModelCellViewModels[indexPath.row]
        if let characterVM = currentViewModel
            as? RMCharacterCollectionViewCellViewModel
        {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RMCharacterCollectionViewCell
                        .collectionIdentifier, for: indexPath
                ) as? RMCharacterCollectionViewCell
            else {
                fatalError()
            }

            cell.configure(with: characterVM)
            return cell
        }

        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodeCollectionViewCell
                    .cellIdentifier,
                for: indexPath
            ) as? RMCharacterEpisodeCollectionViewCell
        else {
            fatalError()
        }
        if let episodeVM = currentViewModel
            as? RMCharacterEpisodeCollectionViewCellViewModel
        {
            cell.configure(with: episodeVM)
        }
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return collectionViewModelCellViewModels.count
    }

    func collectionView(
        _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ) {
        //collectionView.deselectItem(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        switch viewModel.results {
            case .characters:
                delegate?.rmSearchResultsView(self, didTapCharacterAt: indexPath.row)
            case .episodes:
                delegate?.rmSearchResultsView(self, didTapEpisodeAt: indexPath.row)
            case .locations:
                break
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let currentViewModel = collectionViewModelCellViewModels[indexPath.row]
        let bounds = collectionView.bounds

        if currentViewModel is RMCharacterCollectionViewCellViewModel {
            let width = UIDevice.isiPhone ? (bounds.width - 30) / 2 : (bounds.width - 50)/4
            return CGSize(width: width, height: width * 1.5)
        }

        let width = UIDevice.isiPhone ? bounds.width - 20 : (bounds.width-50)/4
        return CGSize(width: width, height: 100)

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath) as? RMFooterLoadingCollectionReusableView else
        { fatalError("Unsupported") }
        if let viewModel = viewModel, viewModel.shouldShowLoadMoreIndicator {
            footer.startAnimating()
        }
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            guard let viewModel = viewModel,
                  viewModel.shouldShowLoadMoreIndicator else {
                return .zero
            }
            return CGSize(width: collectionView.frame.width,
                          height: 100)
        }
}

extension RMSearchResultsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !locationCellViewModels.isEmpty {
            handleLocationPagination(scrollView: scrollView)
        } else {
            handleCharacterOrEpisodePagination(scrollView: scrollView)
        }
    }

    private func handleCharacterOrEpisodePagination(scrollView: UIScrollView) {
        guard let viewModel = viewModel,
        collectionViewModelCellViewModels.isEmpty,
        viewModel.shouldShowLoadMoreIndicator,
        viewModel.isLoadingMoreResults else { return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                viewModel.fetchAdditionalLocation { [weak self] newResults in
                    guard let strongSelf = self else { return }
                    DispatchQueue.main.async {
                        strongSelf.tableView.tableFooterView = nil
                        
                        let originalCount = strongSelf.collectionViewModelCellViewModels.count
                        let newCount = (newResults.count - originalCount)
                        let total = originalCount + newCount
                        let startIndex = total - newCount
                        let indexPathsToAdd: [IndexPath] = Array(startIndex..<(startIndex+newCount)).compactMap({
                            return IndexPath(row: $0, section: 0)
                        })
                        strongSelf.collectionViewModelCellViewModels = newResults
                        strongSelf.collectionView.insertItems(at: indexPathsToAdd)
                    }
                    
                }
            }
            t.invalidate()
        }
    }

    private func handleLocationPagination(scrollView: UIScrollView) {
        guard let viewModel = viewModel,
            !locationCellViewModels.isEmpty,
            viewModel.shouldShowLoadMoreIndicator,
            !viewModel.isLoadingMoreResults
        else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
        
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 100) {
                DispatchQueue.main.async {
                    self?.showTableLoadingIndicator()                    
                }
                viewModel.fetchAdditionalLocation { [weak self] newResults in
                    self?.tableView.tableFooterView = nil
                    self?.locationCellViewModels = newResults
                    self?.tableView.reloadData()
                }
            }
            t.invalidate()
        }
        
    }
    
    private func showTableLoadingIndicator() {
        let footer = RMTableLoadingFooterView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        tableView.tableFooterView = footer
    }
}
