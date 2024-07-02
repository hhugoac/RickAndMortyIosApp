//
//  RMCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//

import UIKit

/// Controller to Character
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {

    private let rmCharacterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title =  "Characters"
        view.addSubview(rmCharacterListView)
        setupView()
    }
    
    private func setupView() {
        rmCharacterListView.delegate = self
        NSLayoutConstraint.activate([
            rmCharacterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rmCharacterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            rmCharacterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rmCharacterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }

    // MARK: - RMCharacterLisViewDelegate
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
