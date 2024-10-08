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
        enum `Type` {
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
            
            var endPoint: RMEndpoint {
                switch self {
                    case .character: return .character
                    case .episode: return .episode
                    case .location: return .location
                }
            }
        }

        let type: `Type`
    }

    private let config: Config
    private let viewModel: RMSearchViewViewModel
    private let searchView: RMSearchView

    init(config: Config) {
        self.config = config
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Search", style: .done, target: self,
            action: #selector(didExecuteSearch))
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc
    private func didExecuteSearch() {
        viewModel.executeSearch()
    }
}

extension RMSearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectLocation location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)    
    }
    
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        print("Should present option picker")
        let vc = RMSearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
    
    
}
