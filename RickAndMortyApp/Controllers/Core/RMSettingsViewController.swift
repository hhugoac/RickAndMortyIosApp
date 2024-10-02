//
//  RMSettingsViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//
import StoreKit
import SafariServices
import SwiftUI
import UIKit

/// Controller to show Settings
final class RMSettingsViewController: UIViewController {

    private var settingsSwiftUIController: UIHostingController<RMSettingView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(
            rootView: RMSettingView(viewModel: RMSettingsViewViewModel(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    return RMSettingsCellViewModel(type: $0) { [weak self] option in
                        self?.handleTap(option: option)
                    }
                    
                })
            ))
        )
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
