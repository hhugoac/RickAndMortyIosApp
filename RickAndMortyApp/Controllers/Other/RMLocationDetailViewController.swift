//
//  RMLocationDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 03/10/24.
//

import UIKit

class RMLocationDetailViewController: UIViewController, RMLocationDetailViewDelegate, RMLocationDetailViewViewModelDelegate {
   
    private let viewModel: RMLocationDetailViewViewModel
    private let detailView = RMLocationDetailView()
    
        // MARK: - Init

    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endpoint: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        title = "Location"
        view.backgroundColor = .systemBackground
        addConstraints()
        detailView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func didTapShare() {
        
    }
    
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
    // MARK: - View delegate

    func rmEpisodeDetailView(_ detailView: RMLocationDetailView, didSelectCharacter character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}
