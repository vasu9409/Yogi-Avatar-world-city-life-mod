//
//  Category_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
// MARK: - Category
struct Category_AW: Codable {
    let id: Int
    let path, preview: String
}

typealias AvatarCategories_AW = [String: [Category_AW]]
