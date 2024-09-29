//
//  MoodsContentModel.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit


class ModsContentModel_AW {
    private var contentService: ContentServiceType_AW
    private var storeManager: StoreManager_AW { .shared }
    
    var originalContent: [ListDTO_AW] = []
    var selectedType: FilterAction_AW?
    var content: [ListDTO_AW] = []
    var onReload: (() -> Void) = { }
    var showLoading_AW: (() -> Void) = { }
    
    init() {
        contentService = ServiceHolder_AW.shared.get_AW(by: ContentService_AW.self)
    }
    
    func checkContent_AW() {
       
        fetchContentImage_AW(with: .mod)
    }
    
    func resetContent_AW() {
        content = originalContent
        onReload()
    }
    
    private func getContent_AW() {
        contentService.getContentModel_AW(with: .mod) { [weak self] contentModel in
            guard let model = contentModel else { return }
            self?.content = self?.uniqueContent_AW(contents: model) ?? []
            self?.originalContent = self?.uniqueContent_AW(contents: model) ?? []
            self?.updateFilter_AW(with: self?.selectedType ?? .all)
        }
    }
    
    private func uniqueContent_AW(contents: [ListDTO_AW]) -> [ListDTO_AW] {
        
        var uniqueContents_AW = [ListDTO_AW]()
        
        for content in contents {
            if !uniqueContents_AW.contains(where: {$0.name == content.name}) {
                uniqueContents_AW.append(content)
            }
        }
        
        return Array(uniqueContents_AW)
    }
    
    func makeSearch_AW(with model: ListDTO_AW) {
        content = originalContent.filter({$0.id == model.id})
        onReload()
    }
    
    func checkUpdateModel_AW(with model: ListDTO_AW) {
        if let index = content.firstIndex(where: {$0.id == model.id}) {
            content[index] = model
        }
        
        if let index = originalContent.firstIndex(where: {$0.id == model.id}) {
            originalContent[index] = model
        }
        
        updateFilter_AW(with: selectedType ?? .all)
        
        onReload()
    }
    
    private func fetchContentImage_AW(with type: ContentType_AW) {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if contentService.isGuidesListEmpty_AW(by: type) {
            self.storeManager.removeAllByType_AW(type: type)
            self.showLoading_AW()
            DBManager_AW.shared.fetchImageDataModel_AW(type: type) {
                dispatchGroup.leave()
                print("🔴 fetching guides image")
            }
            
        } else {
            getContent_AW()
            dispatchGroup.leave()
        }
        
        // Notify when all tasks are completed
        dispatchGroup.notify(queue: .main) {
            // Navigate to the main menu after all tasks are done
            self.getContent_AW()
        }
    }
    
    
    func updateIsFavorites_AW(for contentModel: ListDTO_AW) {
        if let index = content.firstIndex(where: {$0.id == contentModel.id}) {
            content[index].isFavorite = !content[index].isFavorite
            contentService.updateModel_AW(with: .mod, model: content[index])
        }
        
        if let index = originalContent.firstIndex(where: {$0.id == contentModel.id}) {
            originalContent[index].isFavorite = !originalContent[index].isFavorite
        }
        
        updateFilter_AW(with: self.selectedType ?? .all)
        
        onReload()
    }
    
    func updateFilter_AW(with type: FilterAction_AW) {
        self.selectedType = type
        
        switch type {
        case .all:
            self.content = originalContent
        case .favorites:
            self.content = originalContent.filter({$0.isFavorite})
        case .new:
            self.content = originalContent.filter({$0.new})
        case .top:
            self.content = originalContent.filter({$0.type == .top})
        }
        self.onReload()
    }
    
}
