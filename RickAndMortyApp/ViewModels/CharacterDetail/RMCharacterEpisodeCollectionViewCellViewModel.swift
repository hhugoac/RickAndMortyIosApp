//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 19/07/24.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
}
