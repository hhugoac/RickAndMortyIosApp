//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 19/07/24.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    
   
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func downloadImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            return
        }
        RMImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
