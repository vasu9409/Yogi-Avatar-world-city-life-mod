//
//  ContentListDataModel.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation



struct ContentListDataModel_AW {
    let title: String
    var model: [ContentDataModel_AW]
    var isSelected: Bool
}

struct ContentDataModel_AW {
    let id: UUID
    let name, description, imgPath: String
    var isFavorites: Bool
}
