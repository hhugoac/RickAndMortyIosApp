//
//  RMSearchResultViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 07/10/24.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
