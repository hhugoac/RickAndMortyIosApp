//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 19/07/24.
//

import UIKit

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { data in
            print(String(describing: data.name))
            print(String(describing: data.air_date))
            print(String(describing: data.episode))
        }
        viewModel.fetchEpisode()
    }
}
