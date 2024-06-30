//
//  RMCharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 29/06/24.
//

import UIKit

final class RMCharacterListViewViewModel: NSObject {
    
    func fetchListResults() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("SUCCESS: " + String(describing: model.results.count))
                print("SUCCESS: " + String(describing: model.info.count))
            case .failure(let error):
                print("FAILURE: " + String(describing: error))
            }
            
        }
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.collectionIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsuported cell")
        }
        let vieModel = RMCharacterCollectionViewCellViewModel(characterName: "HUgo", characterStatus: .alive, characterImageUrl: nil)
        cell.configure(with: vieModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
}
