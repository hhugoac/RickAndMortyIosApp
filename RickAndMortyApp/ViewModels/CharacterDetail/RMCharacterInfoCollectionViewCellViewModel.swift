//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 19/07/24.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let type:`Type`
    public let value: String
    public let title: String {
        self.type.displayTitle
    }
    
    enum `Type` {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case total
        
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
                case .total:
                    return "Something"
                default:
                    <#code#>
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.type = type
            self.value = value
    }
    
}
