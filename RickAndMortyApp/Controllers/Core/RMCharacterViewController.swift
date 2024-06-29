//
//  RMCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//

import UIKit

/// Controller to Character
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title =  "Characters"
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("SUCCESS: " + String(describing: model))
            case .failure(let error):
                print("FAILURE: " + String(describing: error))
            }
            
        }
    }
    

}
