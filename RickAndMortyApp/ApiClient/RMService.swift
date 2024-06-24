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
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void){
        
    }
}
