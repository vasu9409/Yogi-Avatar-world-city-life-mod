

import Foundation

struct EditorContent: Codable {
    
    let z3D: Z3D
    
    enum BoxingChampionMethodWiseKeysFrame: String, CodingKey {
        case z3D = "z3d"
    }
    
    typealias CodingKeys = BoxingChampionMethodWiseKeysFrame
}

// MARK: - Z3D
struct Z3D: Codable {
    let shoes, eyes, body, mouth: [String: Accessory]
    let clothes, hair, brows, headdress: [String: Accessory]
    let face, accessory: [String: Accessory]

    enum TimeFrameForRegularThings: String, CodingKey {
        case shoes = "Shoes"
        case eyes = "Eyes"
        case body = "Body"
        case mouth = "Mouth"
        case clothes = "Clothes"
        case hair = "Hair"
        case brows = "Brows"
        case headdress = "Headdress"
        case face = "Face"
        case accessory = "Accessory"
    }
    
    typealias CodingKeys = TimeFrameForRegularThings
}

// MARK: - Accessory
struct Accessory: Codable {
    let isNew, isTop: Bool
    let previewImage: String
    let the278Ttts: The278Ttts
    let imageOriginal: String

    enum thingsCanBezierDone: String, CodingKey {
        case isNew, isTop
        case previewImage = "2rw-lv"
        case the278Ttts = "278ttts_"
        case imageOriginal = "227pbhq"
    }
    
    typealias CodingKeys = thingsCanBezierDone
}

enum The278Ttts: String, Codable {
    case boy = "Boy"
    case girl = "Girl"
    case the278TttsBoy = "boy"
    case the278TttsGirl = "girl"
}
