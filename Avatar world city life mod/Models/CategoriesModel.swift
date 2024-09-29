//
//  CategoriesModel.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation

// MARK: - Categories
struct Categories_AW: Codable {
    let categoryList: [CategoryList_AW]

    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

// MARK: - CategoryList
struct CategoryList_AW: Codable {
    let title: TitleList_AW
    let list: [ListCategory_AW]
}

enum TitleList_AW: String, Codable {
    case top = "Top"
    case custom = "Custom"
}

// MARK: - ListCategory
struct ListCategory_AW: Codable {
    let id: Int
    let name, description, imgPath: String
    let new: Bool
    let Oj784hgdsfH: String?

}


struct ListDTO_AW: Codable, Hashable {
    let id: Int?
    let name, description, imgPath: String?
    let new: Bool
    let type: TitleList_AW?
    var isFavorite: Bool
    var data: Data?
    var apkPath: String?
}
