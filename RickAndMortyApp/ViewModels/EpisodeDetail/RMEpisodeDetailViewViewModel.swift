//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 10/09/24.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {
    private let endpoint: URL?
    private var dataTuple: (RMEpisode, [RMCharacter])? {
        didSet {
            delegate?.didFetchEpisodeDetails()
        }
    }
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    enum SectionType {
        case information(viewModels: [RMEpisdoInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharacterCollectionViewCellViewModel])
    }
    
    public private(set) var sections: [SectionType] = []
    init(endpoint: URL?) {
        self.endpoint = endpoint
    }
    
    public func fetchEpisodeData(){
        guard let url = endpoint, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                    self?.fetchRelatedCharacters(episode: model)
            case .failure(let failure):
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: RMEpisode){
        let characterRequests: [RMRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        // 10 parallel request
        // Notified once all done
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        
        characterRequests.forEach { request in
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                switch result {
                    case .success(let character):
                        characters.append(character)
                    case .failure:
                        break
                }
            }
        }
        
        group.notify(queue: .main) {
            //dataTuple = (episode, characters)
        }
    }
}
