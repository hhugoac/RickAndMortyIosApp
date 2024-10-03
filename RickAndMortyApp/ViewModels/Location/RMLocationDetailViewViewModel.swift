//
//  RMLocationDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 03/10/24.
//

import Foundation


protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel {
    private let endpoint: URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharacterCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Init
    
    init(endpoint: URL?) {
        self.endpoint = endpoint
    }
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    // MARK: - PUBlIC
    
    
    // MARK: - PRIVATE
    private func createViewModels(){
        guard let dataTuple = dataTuple else {
            return
        }
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        var createdString = location.created
        
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: createdString) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimesnsion", value: location.dimension),
                .init(title: "Created", value: location.created),
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
            }))
        ]
    }
    /// Fetch backing location model
    public func fetchLocationData(){
        guard let url = endpoint,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                    self?.fetchRelatedLocation(location: model)
            case .failure:
                break
            }
        }
    }
    
    private func fetchRelatedLocation(location: RMLocation){
        let characterRequests: [RMRequest] = location.residents.compactMap({
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
                defer {
                    group.leave()
                }
                switch result {
                    case .success(let character):
                        characters.append(character)
                    case .failure:
                        break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (
                location: location,
                characters: characters
            )
        }
    }
}
