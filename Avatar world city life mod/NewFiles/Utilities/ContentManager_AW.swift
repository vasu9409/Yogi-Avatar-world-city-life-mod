//
//  ContentManager_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//


import Foundation

struct EditorContentDataModel_AW: Codable, Hashable {
    var id: Int
    var name: String
    let type: CharacterContentType_AW
    var imgPath: String
    var previewImgPath: String? = nil
    var imgData: Data?
    var previewImgData: Data?
    var isSelected: Bool
    var isDownloaded: Bool = false
}

struct EditorCategoryDataModel_AW: Codable {
    let type: CharacterContentType_AW
    var isSelected: Bool
}

final class ContentManager_AW: NSObject {
    private var storeManager: StoreManager_AW { .shared }
    private var apkStoreManager: ApkStoreManager_AW { .shared }
    
    var editorContentArray: [EditorContentDataModel_AW] = []
    
    func serialize_AW(data: Data, for contentType: ContentType_AW) {
        switch contentType {
        case .content: 
            var array: [EditorContentData_AW] = []
            let categories = try? JSONDecoder().decode(AvatarCategories_AW.self, from: data)

            guard let categories = categories else { return }
            for (key, value) in categories {
                if let contentType = CharacterContentType_AW(rawValue: key) {
                    for category in value {
                        array.append(EditorContentData_AW(id: category.id, type: contentType, imgPath: "\(contentType.rawValue)/\(category.path)", previewImgPath: "\(contentType.rawValue)/\(category.preview)", isSelected: false))
                    }
                }
            }
            FileSession_AW.shared.saveEditorDropBoxContent_AW(with: array)
        case .houseIdeas:
            guard FileSession_AW.shared.getHouseIdeasDropBoxContent_AW().isEmpty else { return }
           
            getContentModel_AW(with: contentType, data: data) { listElement in
                FileSession_AW.shared.saveHouseIdeasDropBoxContent_AW(with: listElement ?? [])
                
            }
        case .mod:
            guard FileSession_AW.shared.getModsDropBoxContent_AW().isEmpty else { return }
           
            getContentModel_AW(with: contentType, data: data) { listElement in
                FileSession_AW.shared.saveModsDropBoxContent_AW(with: listElement ?? [])
                
            }
        default: break
        }
    }
    
     func isAllModelsUploaded_AW() -> Bool {
        return !FileSession_AW.shared.getHouseIdeasDropBoxContent_AW().isEmpty &&
        !FileSession_AW.shared.getModsDropBoxContent_AW().isEmpty 
    }
    
    func storeApk_AW(by data: Data?,  path: String) {
       
        guard let data = data else { return }
        apkStoreManager.saveAPKFileToDocumentDirectory_AW(data: data, path: path)
        
    }
    
    func getContentModel_AW(with type: ContentType_AW, data: Data,  completion: @escaping([ListDTO_AW]?) -> Void ) {
        switch type {
        case .houseIdeas:
            guard let model = try? JSONDecoder().decode(Categories_AW.self, from: data) else { return  }
            completion(serelize_AW(with: model))
        case .mod:
            guard let model = try? JSONDecoder().decode(Categories_AW.self, from: data) else { return  }
            completion(serelize_AW(with: model))
        default:
            break
        }
    }
    
    func serelize_AW(with model: Categories_AW) -> [ListDTO_AW] {
        return  model.categoryList.flatMap { categoryList in
            categoryList.list.compactMap { list in
                return ListDTO_AW(id: list.id,
                               name: list.name,
                               description: list.description,
                               imgPath: list.imgPath,
                               new: list.new,
                               type: categoryList.title,
                               isFavorite: false,
                               apkPath: list.Oj784hgdsfH)
            }
        }
    }

    
    func getPath_AW(for contentType: ContentType_AW, imgPath: String) -> String {
       
       return  String(format: "/%@/%@", contentType.associatedPath.rawValue, imgPath)
    }
    
    
    func fetchEditorContent_AW() -> [EditorContentDataModel_AW] {
        return FileSession_AW.shared.getEditorContent_AW()
    }
    
    func storeEditorContent_AW(for model: EditorContentData_AW, imgData: Data?, previewImgData: Data?) {
         var updatedSortedArray: [EditorContentDataModel_AW] = []

         if let index = editorContentArray.firstIndex(where: {$0.type == model.type && $0.id == model.id }) {
             guard imgData != nil && previewImgData != nil else { return }
              editorContentArray[index].imgData = imgData
              editorContentArray[index].previewImgData = previewImgData
         }

         // Iterate through each ContentType
         for contentType in CharacterContentType_AW.allCases {

             if imgData == nil || previewImgData == nil {
                 return
             }

             var elementsForContentType = editorContentArray.filter { $0.type == contentType }

             // Find the element with ID 0 (or ID 1 if ID 0 doesn't exist) and set isSelected to true
             if let elementWithID0 = elementsForContentType.first(where: { $0.id == 0 }) ?? elementsForContentType.first(where: { $0.id == 1 }) {
                 elementsForContentType = elementsForContentType.map { model in
                     var updatedModel = model
                     updatedModel.isSelected = (model.id == elementWithID0.id)
                     return updatedModel
                 }
             }

             // Sort the elements by id in ascending order
             elementsForContentType.sort { $0.id < $1.id }

             // Append the sorted and modified elements to the updatedSortedArray
             updatedSortedArray.append(contentsOf: elementsForContentType)
         }

         for index in 0..<updatedSortedArray.count {
              if updatedSortedArray[index].type == .headdress {
                   updatedSortedArray[index].isSelected = false
             }
         }

        var filteredArray = updatedSortedArray.filter({$0.imgData != nil})

         if filteredArray.contains(where: {$0.type == .headdress }) {
             filteredArray.insert(EditorContentDataModel_AW(id: 0, name: "", type: .headdress, imgPath: "", isSelected: true), at: 0)
         }


        FileSession_AW.shared.saveEditorContent_AW(with: filteredArray)
    }
    
    func storeEditorContentWithModel_AW(with content: EditorContentDataModel_AW) {
        editorContentArray.append(content)
    }

    
    func storeImageByType_AW(with model: ListDTO_AW, type: ContentType_AW, data: Data?) {
        switch type {
            
        case .houseIdeas:
            storeManager.save_AW(model: model, type: type, data: data)
        case .mod:
            storeManager.save_AW(model: model, type: type, data: data)
            
        default: break
        }
    }
}

