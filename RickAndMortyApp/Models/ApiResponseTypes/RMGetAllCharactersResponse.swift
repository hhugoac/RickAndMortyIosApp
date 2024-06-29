//
//  RMGetAllCharactersResponse.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 29/06/24.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}
