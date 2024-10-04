//
//  RMEpisodeViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//

import UIKit

final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {

    private let rmEpisodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title =  "Episodes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        view.addSubview(rmEpisodeListView)
        setupView()
    }
    
    
    private func setupView() {
        rmEpisodeListView.delegate = self
        NSLayoutConstraint.activate([
            rmEpisodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rmEpisodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            rmEpisodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rmEpisodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .episode))
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - RMEpisodeLisViewDelegate
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
