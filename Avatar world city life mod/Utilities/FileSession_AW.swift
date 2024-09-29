//
//  FileSession_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
struct CharacterPriviewModel_AW: Codable, Hashable {
    static func == (lhs: CharacterPriviewModel_AW, rhs: CharacterPriviewModel_AW) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
        hasher.combine(uuid)
        hasher.combine(isShowSubs)
    }
    
    let content: [EditorContentDataModel_AW]
    let uuid: UUID
    var isShowSubs: Bool = false
    var preview: Data?
}

enum DropBoxSavePath_AW: String {
    case characters = "characters.json"
    case editorDropBoxContent = "editorDropBoxContent.json"
    case editorContent = "editorContent.json"
    case mods = "mods.json"
    case houseIdeas = "houseIdeas.json"
}

class FileSession_AW {
    
    static let shared = FileSession_AW()
    
    //MARK: - HouseIdeas -
    
    func saveHouseIdeasDropBoxContent_AW(with model: [ListDTO_AW]) {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.houseIdeas.rawValue)
        FileSession_AW.shared.saveModelToFile_AW(model: model, to: fileURL)
    }
    
    func getHouseIdeasDropBoxContent_AW() -> [ListDTO_AW] {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.houseIdeas.rawValue)
        guard let dataModel: [ListDTO_AW] = FileSession_AW.shared.getModelFromFile_AW(from: fileURL) else { return [] }
        return dataModel
    }
    
    func updateHouseIdeasDropBoxContent_AW(with newModel: ListDTO_AW) {
        var existingModels = getHouseIdeasDropBoxContent_AW()
        // Find the index of the element to update
        if let index = existingModels.firstIndex(where: { $0.id == newModel.id }) {
            // Update the element at the found index
            existingModels[index] = newModel
            // Save the updated array back to the file
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.houseIdeas.rawValue)
            FileSession_AW.shared.saveModelToFile_AW(model: existingModels, to: fileURL)
        }
    }
    
    //MARK: - Mods -
    
    func saveModsDropBoxContent_AW(with model: [ListDTO_AW]) {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.mods.rawValue)
        FileSession_AW.shared.saveModelToFile_AW(model: model, to: fileURL)
    }
    
    func getModsDropBoxContent_AW() -> [ListDTO_AW] {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.mods.rawValue)
        guard let dataModel: [ListDTO_AW] = FileSession_AW.shared.getModelFromFile_AW(from: fileURL) else { return [] }
        return dataModel
    }
    
    func updateModDropBoxContent_AW(with newModel: ListDTO_AW) {
        var existingModels = getModsDropBoxContent_AW()
        // Find the index of the element to update
        if let index = existingModels.firstIndex(where: { $0.id == newModel.id }) {
            // Update the element at the found index
            existingModels[index] = newModel
            // Save the updated array back to the file
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.mods.rawValue)
            FileSession_AW.shared.saveModelToFile_AW(model: existingModels, to: fileURL)
        }
    }
    
    //MARK: - Editor -
    
    func saveEditorDropBoxContent_AW(with model: [EditorContentData_AW]) {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.editorDropBoxContent.rawValue)
        FileSession_AW.shared.saveModelToFile_AW(model: model, to: fileURL)
    }
    
    func getEditorDropBoxContent_AW() -> [EditorContentData_AW] {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.editorDropBoxContent.rawValue)
        guard let dataModel: [EditorContentData_AW] = FileSession_AW.shared.getModelFromFile_AW(from: fileURL) else { return [] }
        return dataModel
    }
    
    func saveEditorContent_AW(with model: [EditorContentDataModel_AW]) {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.editorContent.rawValue)
        FileSession_AW.shared.saveModelToFile_AW(model: model, to: fileURL)
    }
    
    func getEditorContent_AW() -> [EditorContentDataModel_AW] {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(DropBoxSavePath_AW.editorContent.rawValue)
        guard let dataModel: [EditorContentDataModel_AW] = FileSession_AW.shared.getModelFromFile_AW(from: fileURL) else { return [] }
        return dataModel
    }
    
    
     
    //MARK: - Private api -
    func saveModelToFile_AW<T: Codable>(model: T, to filePath: URL) {
        do {
            let data = try JSONEncoder().encode(model)
            try data.write(to: filePath)
            print("Model saved to file successfully.")
        } catch {
            print("Error saving model to file: \(error)")
        }
    }
    
    func getModelFromFile_AW<T: Codable>(from filePath: URL) -> T? {
        do {
            let data = try Data(contentsOf: filePath)
            let model = try JSONDecoder().decode(T.self, from: data)
            print("Model retrieved from file successfully.")
            return model
        } catch {
            print("Error retrieving model from file: \(error)")
            return nil
        }
    }
    
}
