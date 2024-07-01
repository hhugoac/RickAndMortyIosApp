//
//  RMCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//

import UIKit

/// Controller to Character
final class RMCharacterViewController: UIViewController {

    private let rmCharacteher = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title =  "Characters"
        view.addSubview(rmCharacteher)
        setupView()
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            rmCharacteher.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rmCharacteher.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            rmCharacteher.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rmCharacteher.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
}
