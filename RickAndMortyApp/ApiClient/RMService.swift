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
    
    enum RMServiceError : Error{
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send Rick And Morty API call
    /// - Parameters:
    ///   - request: Resquest instance
    ///   - type: The type of object expected to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type:T.Type,
        completion: @escaping (Result<T,Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(RMServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - private
    private func request(from rmReuqest: RMRequest) -> URLRequest? {
        guard let url = rmReuqest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
