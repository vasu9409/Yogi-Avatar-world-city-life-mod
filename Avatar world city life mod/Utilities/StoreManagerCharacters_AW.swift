//
//  StoreManagerCharacters_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import RealmSwift

class CharacterPriviewModelObject_AW: Object {
    @Persisted var content: List<EditorContentDataModelObject_AW> 
    @Persisted(primaryKey: true) var uuid: UUID = UUID()
    @Persisted var isShowSubs: Bool = false
    @Persisted var preview: Data?
    
 
}

class EditorContentDataModelObject_AW: Object {
    @Persisted var id: Int
    @Persisted var name: String = ""
    @Persisted var _type: String = ""
    @Persisted var imgPath: String = ""
    @Persisted var previewImgPath: String?
    @Persisted var imgData: Data?
    @Persisted var previewImgData: Data?
    @Persisted var isSelected: Bool
    @Persisted var isDownloaded: Bool = false

    func type_AW() -> CharacterContentType_AW {
       
        return CharacterContentType_AW(rawValue: _type) ?? .body
    }
}

class EditorCategoryDataModelObject_AW: Object {
    @Persisted var type: String = ""
    @Persisted var isSelected: Bool
    
 
}


class StoreManagerCharacters_AW {
    static let shared = StoreManagerCharacters_AW()
    private let realm: Realm
    
    private var currentCountElements: Int = 0
    var isNewElementAdded: Bool = false
    
    private init() {
            do {
                self.realm = try Realm()
            } catch let error as NSError {
                fatalError("Error initializing Realm: \(error.localizedDescription)")
            }
        }
    
    func save_AW(model: CharacterPriviewModel_AW) {
       

            do {
                let realmObject = CharacterPriviewModelObject_AW()
                realmObject.uuid = model.uuid
                realmObject.isShowSubs = model.isShowSubs
                realmObject.preview = model.preview

                for contentModel in model.content {
                    let realmContentModel = EditorContentDataModelObject_AW()
                    realmContentModel.id = contentModel.id
                    realmContentModel.name = contentModel.name
                    realmContentModel._type = contentModel.type.rawValue
                    realmContentModel.imgPath = contentModel.imgPath
                    realmContentModel.previewImgPath = contentModel.previewImgPath
                    realmContentModel.imgData = contentModel.imgData
                    realmContentModel.previewImgData = contentModel.previewImgData
                    realmContentModel.isSelected = contentModel.isSelected
                    realmContentModel.isDownloaded = contentModel.isDownloaded

                    realmObject.content.append(realmContentModel)
                }

                try realm.write {
                    realm.add(realmObject)
                    
                    isNewElementAdded =  realmObject.content.count > currentCountElements
                }
            } catch let error as NSError {
                // Handle error
                print("Error saving to Realm: \(error.localizedDescription)")
            }
        }
    
    func getCharacterPreviewModels_AW() -> [CharacterPriviewModelObject_AW] {
       
        do {
            let results = realm.objects(CharacterPriviewModelObject_AW.self)
            currentCountElements = results.count
            return Array(results)
        } catch let error as NSError {
            // Handle error
            print("Error fetching from Realm: \(error.localizedDescription)")
            return []
        }
    }
    
    func removeAllCharacterPreviewModels_AW() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                isNewElementAdded = false
            }
        } catch let error as NSError {
            // Handle error
            print("Error removing from Realm: \(error.localizedDescription)")
        }
    }
    
    func updateCharacter_AW(with updatedModel: CharacterPriviewModel_AW) {
       
            do {
                guard let characterToUpdate = realm.object(ofType: CharacterPriviewModelObject_AW.self, forPrimaryKey: updatedModel.uuid) else {
                    print("Character with UUID \(updatedModel.uuid) not found.")
                    return
                }

                try realm.write {
                    characterToUpdate.content.removeAll()
                    characterToUpdate.isShowSubs = updatedModel.isShowSubs
                    characterToUpdate.preview = updatedModel.preview

                    for contentModel in updatedModel.content {
                        let realmContentModel = EditorContentDataModelObject_AW()
                        realmContentModel.id = contentModel.id
                        realmContentModel.name = contentModel.name
                        realmContentModel._type = contentModel.type.rawValue
                        realmContentModel.imgPath = contentModel.imgPath
                        realmContentModel.previewImgPath = contentModel.previewImgPath
                        realmContentModel.imgData = contentModel.imgData
                        realmContentModel.previewImgData = contentModel.previewImgData
                        realmContentModel.isSelected = contentModel.isSelected
                        realmContentModel.isDownloaded = contentModel.isDownloaded

                        characterToUpdate.content.append(realmContentModel)
                    }
                }
            } catch let error as NSError {
                // Handle error
                print("Error updating to Realm: \(error.localizedDescription)")
            }
        }
    
    func deleteCharacter_AW(by uuid: UUID) {
       
            do {
                guard let characterToDelete = realm.object(ofType: CharacterPriviewModelObject_AW.self, forPrimaryKey: uuid) else {
                    print("Character with UUID \(uuid) not found.")
                    return
                }

                try realm.write {
                    realm.delete(characterToDelete)
                }
            } catch let error as NSError {
                // Handle error
                print("Error deleting from Realm: \(error.localizedDescription)")
            }
        }
}
