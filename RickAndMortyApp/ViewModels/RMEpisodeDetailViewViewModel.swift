//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 10/09/24.
//

import UIKit

class RMEpisodeDetailViewViewModel {
    private let endpoint: URL?
    
    init(endpoint: URL?) {
        self.endpoint = endpoint
    }
    
    private func fetchEpisodeData(){
        guard let url = endpoint, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { resulr in
            switch resulr {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                break
            }
        }
    }
}
