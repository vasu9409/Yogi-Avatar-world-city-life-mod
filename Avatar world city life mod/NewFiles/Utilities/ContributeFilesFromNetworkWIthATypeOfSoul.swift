

import Foundation
enum ContentType_AW: String, CaseIterable {
    case  unknown = "66ebf80676cb8",
          content = "content",
          mod = "66ebf80665d2f",
          houseIdeas = "66ebf80c744ca"
    
    init?(rawValue: String) {
        switch rawValue {
        case "66ebf80676cb8": self = .unknown
        case "content": self = .content
        case "66ebf80665d2f": self = .mod
        case "66ebf80c744ca": self = .houseIdeas
        default: return nil
        }
    }
    
    
    var associatedPath: Keys_AW.Path_AW {
        switch self {
        case .content:
            return .content
        case .houseIdeas:
            return .content
        case .mod:
            return  .content
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
