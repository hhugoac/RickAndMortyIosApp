//
//  RMCharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 01/07/24.
//

import UIKit

/// View for single characther info
final class RMCharacterDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPurple
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
