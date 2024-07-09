//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 01/07/24.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    var title: String {
        return character.name.uppercased()
    }
    
    public func fetchCharacterData() {
        guard let url = requestUrl,
              let request = RMRequest(url: url) else {
            print("Failed to create")
            return
        }
        RMService.shared.execute(request
                                 , expecting: String.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
        
    }
}
