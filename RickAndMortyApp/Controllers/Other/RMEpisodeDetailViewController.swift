//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 06/09/24.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let viewModel: RMEpisodeDetailViewViewModel
    
    init(url:URL?) {
        self.viewModel = .init(endpoint: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatalError")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }
    


}
