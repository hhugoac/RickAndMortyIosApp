//
//  RMSettingsViewController.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 23/06/24.
//

import SwiftUI
import UIKit

/// Controller to show Settings
final class RMSettingsViewController: UIViewController {

    private let settingsSwiftUIController = UIHostingController(
        rootView: RMSettingView(viewModel: RMSettingsViewViewModel(
            cellViewModels: RMSettingsOption.allCases.compactMap({
                return RMSettingsCellViewModel(type: $0)
            })
        ))
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Settings"
    }
    
    private func addSwiftUIController() {
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

}
