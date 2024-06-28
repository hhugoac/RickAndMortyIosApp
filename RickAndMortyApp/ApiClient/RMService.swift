//
//  RMService.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//

import Foundation

/// Primary API  service object to get Rick and Morty data
final class RMService {
    /// Shared singleton instance
    static let shared = RMService()
    
    ///Privatized constructor
    private init() {}
    
    
    /// Send Rick And Morty API call
    /// - Parameters:
    ///   - request: Resquest instance
    ///   - type: The type of object expected to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type:T.Type,
        completion: @escaping (Result<T,Error>) -> Void){
        
    }
}
