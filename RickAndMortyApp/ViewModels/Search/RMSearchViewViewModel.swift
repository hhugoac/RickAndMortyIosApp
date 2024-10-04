//
//  RMSearchViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 04/10/24.
//

import Foundation

// Responsabilities
// - show search results
// - show no results view
// - kick off API requests

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
}
