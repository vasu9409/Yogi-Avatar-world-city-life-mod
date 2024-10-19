//
//  DBManager_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import Combine
import SwiftyDropbox
import UIKit

final class DBManager_AW: NSObject {
    
    static let shared = DBManager_AW()
    
    let contentManager = ContentManager_AW()
    
    var progressPublisher: AnyPublisher<String, Never> {
        progressSubject.eraseToAnyPublisher()
    }
    
    private var progressSubject = PassthroughSubject<String, Never>()
    var client: DropboxClient?
    
}

// MARK: - Public API

extension DBManager_AW {
    
    
    func connect_AW(completion: ((DropboxClient?) -> Void)? = nil) {
        print("DBManager_AW - connect_AW!")
        
        UserDefaults
            .standard
            .setValue("230EfwOzUA4AAAAAAAAAAX1huz1beG9_FqyWNawL9N2lS8DvsofqB1oMgkuogf6S",
                      forKey: "refresh_token")
        
        let connect_AWionBlock: (_ accessToken: String) -> Void = {
            [unowned self] accessToken in
            
            let client = connect_AWoDropbox(with: accessToken)
            
            print("DBManager_AW - connect_AWed!")
            
            completion?(client)
        }
        
        let refreshTokenBlock: (_ refreshToken: String) -> Void = {
            refreshToken in
            NetworkManager_AW.requestAccessToken_AW(with: refreshToken) {
                accessToken in
                guard let accessToken else {
                    print("DBManager_AW - Error acquiring access token")
                    
                    return
                }
                
                print("DBManager_AW - AccessToken: \(accessToken)")
                
                connect_AWionBlock(accessToken)
            }
        }
        
        if let refreshToken = UserDefaults
            .standard
            .string(forKey: "refresh_token") {
            refreshTokenBlock(refreshToken)
            return
        }
        
        NetworkManager_AW
            .requestRefreshtoken_AW(with: Keys_AW.App_AW.accessCode_AW.rawValue) {
                refreshToken in
                guard let refreshToken else {
                    completion?(nil)
                    return
                }
                
                UserDefaults.setValue(refreshToken, forKey: "refresh_token")
                print("DBManager_AW - Refreshtoken: \(refreshToken)")
                
                refreshTokenBlock(refreshToken)
            }
    }
    
    func fetchModel_AW(completion: @escaping () -> Void) {
        guard InternetManager_AW.shared.checkInternetConnectivity_AW() else {
            completion()
            return
        }
        
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            self.fetchModels_AW(with: client, completion: completion)
        }
        
        if let client { fetchBlock(client); return }
        
        connect_AW { client in
            guard let client else { completion(); return }
            fetchBlock(client)
        }
    }
    
    private func fetchModels_AW(with client: DropboxClient,
                                completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        var path: [DropboxFile] = [] // Initialize path array
        
        // Fetch Dropbox folder contents
        dispatchGroup.enter() // Add dispatch enter before starting Dropbox fetching
        client.files.listFolder(path: "/content").response { result, error in
            if let error = error {
                print("Error fetching folder contents: \(error.localizedDescription)")
                dispatchGroup.leave() // Leave even if there's an error
            } else if let result = result {
                let files = result.entries.map { DropboxFile(entry: $0) }
                path.removeAll() // Clear path array before updating
                path.append(contentsOf: files) // Append all files to path
                
                // Now, fetch models data for each content type
                for type in path {
                    dispatchGroup.enter() // Enter the dispatch group for each content type
                    self.fetchModelsData_AW(contentType: type, client: client) {
                        dispatchGroup.leave() // Leave after fetching models for each type
                    }
                }
                
                dispatchGroup.leave() // Leave after fetching Dropbox contents
            }
        }
        
        // Notify when all tasks are done
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func fetchModelsData_AW(contentType: DropboxFile, client: DropboxClient, completion: @escaping () -> Void) {
        let path = contentType
        let dispatchGroup = DispatchGroup()
        var modelData: Data?
        dispatchGroup.enter()
        
        getFile_AW(client: client, with: path.path + "/content.json") {  data in
            modelData = data
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
            [unowned self] in
            contentManager.serialize_AW(data: modelData ?? Data(), for: contentType.name)
            completion()
        }
    }
    
    func fetchContent_AW(for contentType: ContentType_AW,
                         completion: @escaping () -> Void) {
        guard InternetManager_AW.shared.checkInternetConnectivity_AW() else {
            completion()
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentType.associatedPath.contentPath
            getFile_AW(client: client, with: path) { [unowned self] data in
                guard let data else { completion(); return }
                contentManager.serialize_AW(data: data, for: contentType.rawValue)
                completion()
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_AW { client in
            guard let client else { completion(); return }
            fetchBlock(client)
        }
    }
    
    func fetchApk_AW(by path: String, completion: @escaping () -> Void) {
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            self.fetchApkData_AW(by: path, client: client, completion: completion)
        }
        
        if let client { fetchBlock(client); return }
        
        connect_AW { client in
            guard let client else { completion(); return }
            fetchBlock(client)
        }
    }
    
    func fetchApkData_AW(by path: String, client: DropboxClient, completion: @escaping () -> Void) {
        let pathApk = getPath_MTW(for: .mod, imgPath: path)
        
        let dispatchGroup = DispatchGroup()
        var apkData: Data?
        dispatchGroup.enter()
        
        getFile_AW(client: client, with: pathApk) { data in
            apkData = data
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
            [unowned self] in
            
            contentManager.storeApk_AW(by: apkData, path: path)
            completion()
        }
    }
    
    func fetchEditorContent_AW(completion: @escaping () -> Void) {
        guard InternetManager_AW.shared.checkInternetConnectivity_AW() else {
            completion()
            return
        }
        
        let editorContent = FileSession_AW.shared.getEditorContent_AW()
        
        let filterArray = editorContent.filter({$0.imgData != nil})
        if !filterArray.isEmpty, filterArray.count > 115 && !editorContent.isEmpty {
            completion()
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let markups = FileSession_AW.shared.getEditorDropBoxContent_AW()
            
            if markups.isEmpty {
                completion()
                return
            }
            
            self.fetchEditorContent_AWData(for: markups, with: client, completion: completion)
            
        }
        
        if let client { fetchBlock(client); return }
        
        connect_AW { client in
            guard let client else { completion(); return }
            fetchBlock(client)
        }
    }
    
    func fetchEditorContent_AWData(for serializedData: [EditorContentData_AW],
                                   with client: DropboxClient,
                                   completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        var taskCount = 0
        
        if !serializedData.isEmpty {
            progressSubject.send("\(taskCount)/\(serializedData.count)")
        }
        
        
        for serialized in serializedData {
            dispatchGroup.enter()
            contentManager.storeEditorContentWithModel_AW(with: EditorContentDataModel_AW(id: serialized.id,
                                                                                          name: "\(serialized.type.rawValue)\(serialized.id)",
                                                                                          type: serialized.type,
                                                                                          imgPath: serialized.imgPath,
                                                                                          isSelected: false))
            
            fetchData_AW(for: serialized, client: client) { [weak self] in
                taskCount += 1
                self?.progressSubject.send("\(taskCount)/\(serializedData.count)")
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { completion() }
    }
    
    func fetchData_AW(for model: EditorContentData_AW, client: DropboxClient, completion: @escaping () -> Void) {
        
        let pathKey = Keys_AW.Path_AW.content
        let path = pathKey.getPathContent_AW(forMarkup: model.imgPath)
        let previewImgPath = pathKey.getPathContent_AW(forMarkup: model.previewImgPath)
        
        let dispatchGroup = DispatchGroup()
        var imgData: Data?
        var imgPreviewData: Data?
        
        dispatchGroup.enter()
        getFile_AW(client: client, with: path) { data in
            print("🔵", data)
            imgData = data
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getFile_AW(client: client, with: previewImgPath) { data in
            imgPreviewData = data
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
            [unowned self] in
            contentManager.storeEditorContent_AW(for: model, imgData: imgData, previewImgData: imgPreviewData)
            completion()
        }
    }
    
    func fetchImageDataModel_AW(type: ContentType_AW, completion: @escaping () -> Void) {
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            self.fetchImage_AW(type: type, client: client, completion: completion)
        }
        
        if let client { fetchBlock(client); return }
        
        connect_AW { client in
            guard let client else { completion(); return }
            fetchBlock(client)
        }
    }
    
    private func fetchImage_AW(type: ContentType_AW, client: DropboxClient, completion: @escaping () -> Void) {
        var array: [ListDTO_AW] = []
        switch type {
            
        case .houseIdeas:
            array = FileSession_AW.shared.getHouseIdeasDropBoxContent_AW()
        case .mod:
            array = FileSession_AW.shared.getModsDropBoxContent_AW()
            
        default: break
        }
        
        let dispatchGroup = DispatchGroup()
        
        for (_, list) in array.enumerated() {
            dispatchGroup.enter()
            
            fetchImageData_AW(list: list, client: client, type: type) {
                dispatchGroup.leave()
            }
            
        }
        
        dispatchGroup.notify(queue: .main) { completion() }
        
    }
    
    func fetchImageData_AW(list: ListDTO_AW, client: DropboxClient, type: ContentType_AW, completion: @escaping () -> Void) {
        guard let imgPath = list.imgPath else { return }
        let path = getPath_MTW(for: type, imgPath: imgPath)
        
        let dispatchGroup = DispatchGroup()
        var imageData: Data?
        dispatchGroup.enter()
        
        getFile_AW(client: client, with: path) { dataImage in
            imageData = dataImage
            print("😈\(type) \(dataImage) path -> \(path)")
            dispatchGroup.leave()
            
        }
        
        dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
            [unowned self] in
            contentManager.storeImageByType_AW(with: list, type: type, data: imageData)
            
            completion()
        }
    }
    
    func getPath_MTW(for contentType: ContentType_AW, imgPath: String) -> String {
        String(format: "/%@/%@", contentType.associatedPath.rawValue, imgPath)
    }
    
    func isAllModelsUploaded_AW() -> Bool {
        contentManager.isAllModelsUploaded_AW()
    }
    
}

// MARK: - Private API


private extension DBManager_AW {
    //
    func connect_AWoDropbox(with accessToken: String) -> DropboxClient {
        let client = DropboxClient(accessToken: accessToken)
        
        self.client = client
        
        return client
    }
    
    func getFile_AW(with path: String, completion: @escaping (Data?) -> Void) {
        print(path)
        let block: (DropboxClient) -> Void = { client in
            client.files.download(path: path).response { response, error in
                if let error = error {
                    print(error.description)
                }
                completion(response?.1)
            }
        }
        
        if let client { block(client); return }
        
        connect_AW { client in
            guard let client else {
                completion(nil)
                return
            }
            
            block(client)
        }
    }
    
    func getFile_AW(client: DropboxClient,
                    with path: String,
                    completion: @escaping (Data?) -> Void) {
        client.files.download(path: path).response { response, error in
            if let error {
                print("🛑\(path)",error.description)
            }
            
            completion(response?.1)
        }
    }
    
    func getLink_AW(client: DropboxClient,
                    path: String,
                    completion: @escaping (String, Files.Metadata?) -> Void) {
        client.files.getTemporaryLink(path: path).response { response, error in
            if let error { print(error.description) }
            
            completion(response?.link ?? "", response?.metadata)
        }
    }
}

