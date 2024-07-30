//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 19/07/24.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    private let type:`Type`
    private let value: String
    
    public var title: String {
        self.type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None"}
        return value
    }
    
    public var iconImage: String {
        return type.iconImage
    }
    
    enum `Type` {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var iconImage: UIImage? {
            switch self {
                case .status:
                    return UIImage(systemName: "bell")
                case .gender:
                    return UIImage(systemName: "bell")
                case .type:
                    return UIImage(systemName: "bell")
                case .species:
                    return UIImage(systemName: "bell")
                case .origin:
                    return UIImage(systemName: "bell")
                case .location:
                    return UIImage(systemName: "bell")
                case .created:
                    return UIImage(systemName: "bell")
                case .episodeCount:
                    return UIImage(systemName: "bell")
            }
        }
        var displayTitle: String {
            switch self {
                case .status:
                    return "Something"
                case .gender:
                    return "Something"
                case .type:
                    return "Something"
                case .species:
                    return "Something"
                case .origin:
                    return "Something"
                case .location:
                    return "Something"
                case .created:
                    return "Something"
                case .episodeCount:
                    return "Something"
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.type = type
            self.value = value
    }
    
}
