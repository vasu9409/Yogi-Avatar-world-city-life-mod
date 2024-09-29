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
    
    
    func type_AW() -> ContentType_AW {
       
        return ContentType_AW(rawValue: contentType)!
    }
    
    func titleType_AW() -> TitleList_AW {
       
        return TitleList_AW(rawValue: titleType)!
    }
}

class StoreManager_AW {
    static let shared = StoreManager_AW()
    private let realm = try! Realm()
    
    func save_AW(model: ListDTO_AW, type: ContentType_AW, data: Data?) {
        print("\(type) is saved")
        
        // Perform the write operation on a background thread
        DispatchQueue.global().async {
            let realm = try! Realm()
            try! realm.write {
                let object = ListElementObject()
                object.id = model.id
                object.title = model.name
                object.contentType = type.rawValue
                object.titleType = model.type?.rawValue ?? ""
                object.descriptionText = model.description
                object.isFavorite = model.isFavorite
                object.new = model.new
                object.data = data
                object.apkPath = model.apkPath
                realm.add(object)
            }
        }
    }
    
    func getGuidesListElementsByType_AW(type: ContentType_AW, completion: @escaping ([ListDTO_AW]) -> Void) {
        // Perform the read operation on a background thread
        DispatchQueue.global().async {
            let realm = try! Realm()
            let objects = realm.objects(ListElementObject.self).filter("contentType = %@", type.rawValue)
            let elementObjects = Array(objects)
            
            // Convert ListElementObject to GuidesListElement
            let elements = elementObjects.map { object in
                return ListDTO_AW(
                    id: object.id,
                    name: object.title,
                    description: object.descriptionText,
                    imgPath: "",
                    new: object.new,
                    type: TitleList_AW(rawValue: object.titleType),
                    isFavorite: object.isFavorite,
                    data: object.data,
                    apkPath: object.apkPath
                )
            }
            
            // Call the completion handler on the main thread with the results
            DispatchQueue.main.async {
                completion(elements)
            }
        }
    }
    
    func updateModel_AW(byType type: ContentType_AW, updatedModel: ListDTO_AW) {
        // Perform the update operation on a background thread
        DispatchQueue.global().async {
            let realm = try! Realm()
            
            // Find the existing object with the given type and UUID
            if let existingObject = realm.objects(ListElementObject.self).filter("contentType = %@ AND id = %@", type.rawValue, updatedModel.id ?? 777).first {
                try! realm.write {
                    existingObject.isFavorite = updatedModel.isFavorite
                }
            }
        }
    }
    
    func removeAllByType_AW(type: ContentType_AW) {
        // Perform the delete operation on a background thread
            let realm = try! Realm()
            let objectsToDelete = realm.objects(ListElementObject.self).filter("contentType = %@", type.rawValue)
            try! realm.write {
                realm.delete(objectsToDelete)
            }
    }
    
    func isGuidesListEmpty_AW(type: ContentType_AW) -> Bool {
        let realm = try! Realm()
        let objects = realm.objects(ListElementObject.self).filter("contentType = %@", type.rawValue)
        let uniqueObjects = filterObjectsForUniqueTitles_AW(objects: objects)
        let isEmpty: Bool
        switch type {
        case .mod:
            isEmpty = uniqueObjects.count != FileSession_AW.shared.getModsDropBoxContent_AW().count || objects.isEmpty
        case .houseIdeas:
            isEmpty = uniqueObjects.count != FileSession_AW.shared.getHouseIdeasDropBoxContent_AW().count || objects.isEmpty
        default:
            return false
        }
        return isEmpty
    }
    
    func getGuidesListCount_AW(type: ContentType_AW) -> Int {
        let realm = try! Realm()
        let objects = realm.objects(ListElementObject.self).filter("contentType = %@", type.rawValue)
        let count = objects.filter({$0.data != nil}).count
        
        // Call the completion handler on the main thread with the result
        return count
        
    }
    
    
    func filterObjectsForUniqueTitles_AW(objects: Results<ListElementObject>) -> [ListElementObject] {
        var uniqueTitles = Set<String>()
        var uniqueObjects = [ListElementObject]()
        for object in objects {
            if !uniqueTitles.contains(object.title ?? "") {
                uniqueTitles.insert(object.title ?? "")
                uniqueObjects.append(object)
            }
        }
        return uniqueObjects
    }
    
}
