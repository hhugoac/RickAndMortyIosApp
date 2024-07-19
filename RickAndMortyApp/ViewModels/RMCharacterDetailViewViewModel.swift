//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 01/07/24.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    // MARK: Init
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    var title: String {
        return character.name.uppercased()
    }
    
}
