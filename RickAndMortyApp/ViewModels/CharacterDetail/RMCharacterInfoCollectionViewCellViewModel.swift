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
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    public var title: String {
        self.type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None"}
        
        if type == .created {
            print(value)
        }
        if let date = Self.dateFormatter.date(from: value),
           type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
                case .status:
                    return .systemBlue
                case .gender:
                    return .systemRed
                case .type:
                    return .systemPurple
                case .species:
                    return .systemGreen
                case .origin:
                    return .systemOrange
                case .location:
                    return .systemPink
                case .created:
                    return .systemYellow
                case .episodeCount:
                    return .systemMint
            }
        }

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
                case .status, .gender,.type, .species, .origin, .location, .created:
                    return rawValue.uppercased()
                case .episodeCount:
                    return "EPISODE COUNT"
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.type = type
            self.value = value
    }
    
}
