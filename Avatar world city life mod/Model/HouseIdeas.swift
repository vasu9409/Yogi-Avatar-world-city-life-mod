//
//  Mods.swift
//  Avatar world city life mod
//
//  Created by Mac Mini on 19/10/24.
//

import Foundation

struct HouseIdeas: Codable {
    
    let um3Jdnw: Um3Jdnw

    enum CodingKeys: String, CodingKey {
        
        case um3Jdnw = "um3jdnw"
    }
}

struct Um3Jdnw: Codable {
    let the8Ua8Onb: [String: The8Ua8Onb]

    enum CodingKeys: String, CodingKey {
        case the8Ua8Onb = "8ua8onb"
    }
}

// MARK: - The8Ua8Onb
struct The8Ua8Onb: Codable {
    let the1477, description, title, h5Pv4Mzkj: String
    let isNew, isTop: Bool

    enum CodingKeys: String, CodingKey {
        case the1477 = "1477"
        case description = "3_vv3"
        case title = "-40zlj0"
        case h5Pv4Mzkj = "h5pv4mzkj"
        case isNew, isTop
    }
}
