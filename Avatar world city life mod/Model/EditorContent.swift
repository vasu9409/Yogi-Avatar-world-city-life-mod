//
//  EditorContent.swift
//  Avatar world city life mod
//
//  Created by Mac Mini on 19/10/24.
//

import Foundation

struct EditorContent: Codable {
    
    let z3D: Z3D
    
    enum CodingKeys: String, CodingKey {
        case z3D = "z3d"
    }
}

// MARK: - Z3D
struct Z3D: Codable {
    let shoes, eyes, body, mouth: [String: Accessory]
    let clothes, hair, brows, headdress: [String: Accessory]
    let face, accessory: [String: Accessory]

    enum CodingKeys: String, CodingKey {
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
}

// MARK: - Accessory
struct Accessory: Codable {
    let isNew, isTop: Bool
    let the2RwLV: String
    let the278Ttts: The278Ttts
    let the227Pbhq: String

    enum CodingKeys: String, CodingKey {
        case isNew, isTop
        case the2RwLV = "2rw-lv"
        case the278Ttts = "278ttts_"
        case the227Pbhq = "227pbhq"
    }
}

enum The278Ttts: String, Codable {
    case boy = "Boy"
    case girl = "Girl"
    case the278TttsBoy = "boy"
    case the278TttsGirl = "girl"
}
