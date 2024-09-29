//
//  ContentService.swift
//  mods-for-toca-world-4
//
//  Created by Alex N
//

import Foundation

protocol ContentServiceType_AW: Service_AW {
    func getContentModel_AW(with type: ContentType_AW, completion: @escaping([ListDTO_AW]?) -> Void)
    func updateModel_AW(with type: ContentType_AW, model: ListDTO_AW)
    func isGuidesListEmpty_AW(by type: ContentType_AW) -> Bool
}

class ContentService_AW: ContentServiceType_AW {
    
    private var storeManager: StoreManager_AW { .shared }
    
    deinit {
        print("ContentService - deinit")
    }
    
    func updateModel_AW(with type: ContentType_AW, model: ListDTO_AW) {
        switch type {

        case .houseIdeas:
            storeManager.updateModel_AW(byType: type, updatedModel: model)
        case .mod:
            storeManager.updateModel_AW(byType: type, updatedModel: model)
        
        default:
            break
        }
    }
    
    func getContentModel_AW(with type: ContentType_AW, completion: @escaping([ListDTO_AW]?) -> Void ) {
        switch type {

        case .houseIdeas:
            storeManager.getGuidesListElementsByType_AW(type: type, completion: completion)
        case .mod:
            storeManager.getGuidesListElementsByType_AW(type: type, completion: completion)
        default:
            break
        }
    }
    
    func isGuidesListEmpty_AW(by type: ContentType_AW) -> Bool {
        switch type {

        case .houseIdeas:
            return FileSession_AW.shared.getHouseIdeasDropBoxContent_AW().count != storeManager.getGuidesListCount_AW(type: type)
        case .mod:
            return FileSession_AW.shared.getModsDropBoxContent_AW().count != storeManager.getGuidesListCount_AW(type: type)
        default:
            return true
        }
    }
}
