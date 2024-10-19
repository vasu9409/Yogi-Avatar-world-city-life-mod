//
//  Mods.swift
//  Avatar world city life mod
//
//  Created by Mac Mini on 19/10/24.
//

import Foundation

struct Mods: Codable {
    
    let the7Rqpw: The7Rqpw

    enum CodingKeys: String, CodingKey {
        
        case the7Rqpw = "7rqpw"
    }
}

// MARK: - The7Rqpw
struct The7Rqpw: Codable {
    let e8V: [String: E8V]

    enum CodingKeys: String, CodingKey {
        case e8V = "e8v"
    }
}

// MARK: - E8V
struct E8V: Codable {
    let the00Ika: String
    let isPopular: Bool
    let description, pn1, title: String
    let isNew: Bool

    enum CodingKeys: String, CodingKey {
        case the00Ika = "00ika"
        case isPopular
        case description = "iv9k44qfj"
        case pn1 = "pn1_"
        case title = "j5snz"
        case isNew
    }
}
