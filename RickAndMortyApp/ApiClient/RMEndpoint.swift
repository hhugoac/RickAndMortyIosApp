//
//  RMEndpoint.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//

import Foundation

/// Represent API endpoint
@frozen enum RMEndpoint: String {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location
    case location
    /// Endpoint to get episode info
    case episode
}
