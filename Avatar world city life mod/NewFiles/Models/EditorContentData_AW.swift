//
//  EditorContentData_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation

struct EditorContentData_AW: Codable, Hashable {
    let id: Int
    let type: CharacterContentType_AW
    let imgPath: String
    var previewImgPath: String
    var isSelected: Bool
}
