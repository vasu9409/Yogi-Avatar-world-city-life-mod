//
//  StoreManager_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import RealmSwift

class ListElementObject: Object {
    
    @Persisted var id: Int?
    @Persisted var title: String?
    @Persisted var contentType = "unknown"
    @Persisted var titleType = "unknown"
    @Persisted var descriptionText: String?
    @Persisted var isFavorite: Bool
    @Persisted var new = false
    @Persisted var data: Data?
    @Persisted var apkPath: String?
    
}
