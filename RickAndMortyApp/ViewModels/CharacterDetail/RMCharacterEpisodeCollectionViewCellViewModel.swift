//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 19/07/24.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    let episodeDataUrl: URL?
    
    private var isFetching = false
    
    // MARK: - Init
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            return
        }
        guard let url = episodeDataUrl,
              let rmRequest = RMRequest(url: url) else {
            return
        }
        print("created:")
    }
}
