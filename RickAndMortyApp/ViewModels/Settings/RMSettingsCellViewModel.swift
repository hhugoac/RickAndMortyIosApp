//
//  RMSettingsCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 01/10/24.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable, Hashable {
    let id = UUID()
    
    public var title: String {
        return type.displayTitle
    }
    public var image: UIImage? {
        return type.iconImage
    }
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
    
    private let type: RMSettingsOption
    
    init(type: RMSettingsOption) {
        self.type = type
    }
}
