//
//  ContentType_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
enum ContentType_AW: String, CaseIterable {
    case  unknown = "unknown",
          content = "content",
          mod = "mod",
          houseIdeas = "houseIdeas"
    
    init?(rawValue: String) {
        switch rawValue {
        case "unknown": self = .unknown
        case "content": self = .content
        case "mod": self = .mod
        case "houseIdeas": self = .houseIdeas
        default: return nil
        }
    }
    
    
    var associatedPath: Keys_AW.Path_AW {
        switch self {
        case .content:
            return .content
        case .houseIdeas:
            return .houseIdeas
        case .mod:
            return  .mods
        case .unknown:
            return .content
        }
    }
    
    var localizedTitle: String {
        let key: String
        
        switch self {
        case .content:
            key = "Contents"
        case .houseIdeas:
            key = "House Ideas"
        case .mod:
            key = "Mods"
        case .unknown:
            key = ""
        }
        
        return key
    }
    
}
