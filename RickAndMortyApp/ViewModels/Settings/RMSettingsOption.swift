//
//  RMSettingsOption.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 01/10/24.
//

import UIKit

enum RMSettingsOption: CaseIterable{
    case rateApp
    case contactUs
    case termns
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var displayTitle: String{
        switch self{
        case .rateApp: return "Rate App"
        case .contactUs: return "Contact Us"
        case .termns: return "Terms"
        case .privacy: return "Privacy"
        case .apiReference: return "API Reference"
        case .viewSeries: return "View Series"
        case .viewCode: return "View Code"
        }
    }
    
    var targetUrl: URL? {
        switch self{
        case .rateApp: return nil
        case .contactUs: return URL(string: "https://iosacademy.io/contact/")
        case .termns: return URL(string: "https://iosacademy.io/terms/")
        case .privacy: return URL(string: "https://iosacademy.io/privacy/")
        case .apiReference: return URL(string: "https://iosacademy.io")
        case .viewSeries: return URL(string: "https://iosacademy.io")
        case .viewCode: return URL(string: "https://iosacademy.io")
        }
    }
    
    var iconContainerColor: UIColor{
        switch self{
        case .rateApp: return .systemRed
        case .contactUs: return .systemBlue
        case .termns: return .systemGreen
        case .privacy: return .systemGray
        case .apiReference: return .systemYellow
        case .viewSeries: return .systemOrange
        case .viewCode: return .systemPurple
        }
    }
    
    var iconImage : UIImage?{
        switch self{
            case .rateApp: return UIImage(systemName: "star.fill")
        case .contactUs: return UIImage(systemName: "paperplane")
        case .termns: return UIImage(systemName: "doc")
        case .privacy: return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
