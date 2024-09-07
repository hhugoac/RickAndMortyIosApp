//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 06/09/24.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    private let url: URL?
    
    init(url:URL?) {
        self.url = url
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
