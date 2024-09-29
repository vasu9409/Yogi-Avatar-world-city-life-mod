//
//  DetailViewModel.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation

class DetailViewModel_AW {
    
    init() {
        contentService = ServiceHolder_AW.shared.get_AW(by: ContentService_AW.self)
    }
    
    private var contentService: ContentServiceType_AW
    private var apkStoreManager: ApkStoreManager_AW { .shared }
    
    var content: [ListDTO_AW] = []
    var onReload: (() -> Void) = { }

    func setupContent_AW(with model: ListDTO_AW) {
       
        content.append(model)
        onReload()
    }
    
    func updateIsFavorites_AW_AW(for contentModel: ListDTO_AW, type: ContentType_AW) {
        if let index = content.firstIndex(where: {$0.id == contentModel.id}) {
            content[index].isFavorite = !content[index].isFavorite
            contentService.updateModel_AW(with: type, model: content[index])
        }
        
        onReload()
    }
    
    func fetchIpa_AW(by path: String, completion: @escaping (URL) -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if apkStoreManager.checkAPKIfFileExistsInDocumentDirectory_AW(path: path) {
            guard let url = apkStoreManager.fetchAPKFileFromDocumentDirectory_AW(path: path) else { return }
            completion(url)
            dispatchGroup.leave()
        } else {
        DBManager_AW.shared.fetchApk_AW(by: path) {
                print("🔴 fetched ipa ")
                dispatchGroup.leave()
            }
        }
        
        // Notify when all tasks are completed
        dispatchGroup.notify(queue: .main) {
            guard let url = self.apkStoreManager.fetchAPKFileFromDocumentDirectory_AW(path: path) else { return }
            completion(url)
        }
    }
}
