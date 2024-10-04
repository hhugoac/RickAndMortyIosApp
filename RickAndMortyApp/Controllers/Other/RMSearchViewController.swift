//
//  RMSearchViewController.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 23/09/24.
//

import UIKit

/// Configure controller to search
final class RMSearchViewController: UIViewController {

    /// Configuration for search session
    struct Config {
        enum `Type`{
            case character
            case episode
            case location
            
            var title: String {
                switch self {
                    case .character: return "Search Characters"
                    case .episode: return "Search Episodes"
                    case .location: return "Search Locations"
                }
            }
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
        // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        
    }
    

   

}
