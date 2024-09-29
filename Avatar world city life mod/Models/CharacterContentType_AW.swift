//
//  CharacterContentType_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

enum CharacterContentType_AW: String, CaseIterable, Codable {
    case body = "body",
         shoes = "shoes",
         hair = "hair",
         eyes = "eyes",
         nose = "nose",
         brows = "brows",
         mouth = "mouth",
         headdress = "headdress",
         top = "top",
         trousers = "trousers",
         hairBack = "hairBack"
    
    init?(rawValue: String) {
        switch rawValue {
        case "body": self = .body
        case "hair": self = .hair
        case "headdress": self = .headdress
        case "brows": self = .brows
        case "trousers": self = .trousers
        case "eyes": self = .eyes
        case "nose": self = .nose
        case "top": self = .top
        case "shoes": self = .shoes
        case "mouth": self = .mouth
        case "hairBack": self = .hairBack
        default: return nil
        }
    }
}

// MARK: - Content

extension CharacterContentType_AW {
    
    var localizedTitle: String {
        let key: String
        
        switch self {
        case .hair:
            key = "Hair"
        case .headdress:
            key = "Hats"
        case .brows:
            key = "Eyebrows"
        case .trousers:
            key = "Pants"
        case .eyes:
            key = "Eyes"
        case .nose:
            key = "Nose"
        case .top:
            key = "Top"
        case .shoes:
            key = "Shoes"
        case .mouth:
            key = "Mouth"
        case .body:
            key = "Colors"
        case .hairBack:
            key = "Hair back"
        }
        
        return NSLocalizedString(key, comment: "")
    }
    
    var preview: UIImage {
        switch self {
        case .hair:
            return #imageLiteral(resourceName: "Hair")
        case .headdress:
            return #imageLiteral(resourceName: "hats")
        case .brows:
            return #imageLiteral(resourceName: "Eyebrow")
        case .trousers:
            return #imageLiteral(resourceName: "trousers")
        case .eyes:
            return #imageLiteral(resourceName: "Eyes")
        case .nose:
            return #imageLiteral(resourceName: "Nose")
        case .top:
            return #imageLiteral(resourceName: "top")
        case .shoes:
            return #imageLiteral(resourceName: "Shoes")
        case .mouth:
            return #imageLiteral(resourceName: "Mouth")
        case .body:
            return #imageLiteral(resourceName: "Color")
        case .hairBack:
            return #imageLiteral(resourceName: "Color")
        }
    }
}
