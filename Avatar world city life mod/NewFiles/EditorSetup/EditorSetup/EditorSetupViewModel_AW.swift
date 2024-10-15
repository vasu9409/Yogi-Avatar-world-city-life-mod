//
//  EditorSetupViewModel.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
class EditorSetupViewModel_AW {
    
    private var originalContent: [EditorContentDataModel_AW] = []
    var category: [EditorCategoryDataModel_AW] = [ ]
    var content: [EditorContentDataModel_AW] = [ ]
    var onUpdateColor: ((EditorContentDataModel_AW) -> Void) = { _ in }
    var onUpdateContent_AW: ((EditorContentDataModel_AW) -> Void) = { _ in }
    var onUpdateCategory_AW: ((EditorCategoryDataModel_AW) -> Void) = { _ in }
    var onLoadContent_AW: (() -> Void) = { }
    
    var allContent: [EditorContentDataModel_AW] = [ ]
    var editContent: [EditorContentDataModel_AW] = [ ]
    
    init() {
        checkSelectedCategory_AW()
    }
    
    func setupContent_AW(with model: [EditorContentDataModel_AW]) {
        let selectedContent = model.filter({$0.isSelected == true })
        self.editContent = selectedContent
    }
    
    func loadSelectedContent_AW(with content: [EditorContentDataModel_AW]) {
        let filteredContent = content.filter({$0.isSelected})
        filteredContent.forEach { [weak self] contentModel in
            self?.makeSelectedContent_AW(model: contentModel)
        }
        
        onLoadContent_AW()
    }
    
    func loadContent_AW(with content: [EditorContentDataModel_AW]) {
        self.allContent = content
        self.content = content
        
        CharacterContentType_AW.allCases.forEach({
            category.append(EditorCategoryDataModel_AW(type: $0, isSelected: false))
        })
        
        category.removeLast()
        category[0].isSelected = true
        
        if !editContent.isEmpty {
            editContent.forEach { [weak self] contentModel in
                self?.makeSelectedContent_AW(model: contentModel)
            }
        }
        
        onLoadContent_AW()
    }
    
    func changeStatusDownloadingImage_AW(with content: EditorContentDataModel_AW, isDownloaded: Bool) {
       
        if let index = self.content.firstIndex(where: {$0 == content}) {
            self.content[index].isDownloaded = true
        }
    }
    
 
    func checkSelectedCategory_AW() {
        let selectedCategory = category.first(where: { $0.isSelected }) == nil ? category.first : category.first(where: { $0.isSelected })
        let contentFrmCategory: [EditorContentDataModel_AW] = allContent.filter({$0.type == selectedCategory?.type })
        content = contentFrmCategory
        originalContent = content
    }
    
    func makeSelected_AW(type: CharacterContentType_AW) {
       
        
        dismissSelectionCategory_AW()
        for index in 0..<category.count {
            if category[index].type == type {
                category[index].isSelected = true
                onUpdateCategory_AW(category[index])
            }
        }
        checkSelectedCategory_AW()
    }
    
    
    private func dismissSelectionCategory_AW() {
       
        
        for i in 0..<category.count {
            category[i].isSelected = false
        }
    }
    
   
    func makeSelectedContent_AW(model: EditorContentDataModel_AW) {
        dismissSelectionContent_AW()
        for index in 0..<content.count {
            if content[index].name == model.name {
                content[index].isSelected = true
                onUpdateContent_AW(content[index])
            }
        }
        
        setSelectedByImgPath_AW(model.name, type: model.type)
    }
    
    func makeSelectedContentColor_AW(imgPath: String, type: CharacterContentType_AW) {
       
        
        dismissSelectionContent_AW()
        for index in 0..<content.count {
            if content[index].name == imgPath {
                content[index].isSelected = true
                onUpdateColor(content[index])
            }
        }
        
        setSelectedByImgPath_AW(imgPath, type: type)
    }
    
    
    func setSelectedByImgPath_AW(_ imgPath: String, type: CharacterContentType_AW) {
        for index in 0..<allContent.count {
            var item = allContent[index]
            if item.type == type {
                if item.name == imgPath {
                    item.isSelected = true
                } else {
                    item.isSelected = false
                }
                allContent[index] = item
            }
        }
        
        if type == .hair {
            for index in 0..<allContent.count {
                if allContent[index].type == .hairBack {
                    allContent[index].isSelected = false
                }
            }
            
            guard let lastCharacter = imgPath.last else { return }
            let count: String = String(lastCharacter)
            if let indexHeaderBack = allContent.firstIndex(where: {$0.type == .hairBack && $0.name.contains(count)}) {
                allContent[indexHeaderBack].isSelected = true
            }
            
            
        }
        
        onLoadContent_AW()
    }
    
    func getContentTitle_AW() -> String {
       
        let selectedCategory = category.first(where: { $0.isSelected })
        let contentFrmCategory: [EditorContentDataModel_AW] = allContent.filter({$0.type == selectedCategory?.type })
        return contentFrmCategory.first?.type.localizedTitle ?? ""
    }
    
    private func dismissSelectionContent_AW() {
        
        for i in 0..<content.count {
            content[i].isSelected = false
        }
    }
    
    func hasContentChanged_AW() -> Bool {
        return content != originalContent
    }
}
