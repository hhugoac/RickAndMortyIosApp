//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 19/07/24.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    
    public let value: String
    public let title: String
    
   init(value: String, title: String) {
            self.value = value
            self.title = title
    }
    
}
