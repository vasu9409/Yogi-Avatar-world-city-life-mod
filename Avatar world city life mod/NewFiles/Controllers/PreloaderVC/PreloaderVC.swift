//
//  PreloaderVC.swift
//  Avatar world city life mod
//
//  Created by Mac Mini on 19/10/24.
//

import UIKit
import SwiftyDropbox

protocol PreloaderViewControllerTransition: AnyObject {
    func didEndUploading()
}

var filesPath: [URL] = []

var totalFoldersInDropbox: [String] = []

var foldersFiles: [DropboxFileContent] = []

struct DropboxFileContent {
    
    let folderName: String
    let fileName: String
    
}

class PreloaderVC: UIViewController {
    
    @IBOutlet weak var rightTrailingConstant: NSLayoutConstraint!
    @IBOutlet weak var leftLeadingConstant: NSLayoutConstraint!
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var internetConnectionLabel: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var leanerarProgressView: LinearProgressBar!
    @IBOutlet weak var okInternetButton: UIButton!
    @IBOutlet weak var intenetConnectionView: UIView!
    
    weak var transition: PreloaderViewControllerTransition?
    private var totalFiles: Int = 0
    private var completedFiles: Int = 0
    
    private var timer: Timer?
    private var elapsedTime: TimeInterval = 0
    private var maxDuration: TimeInterval = 35.0
    
    let specificFolders = ["66ebf80c744ca", "66ebf80665d2f"]
    var filteredFiles: [DropboxFileContent] = []
    
    let localFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path + "/content"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.connectionView.isHidden = true
        
        if UIScreen.main.nativeBounds.height == 2360 {
            self.leftLeadingConstant.constant = 100
            self.rightTrailingConstant.constant = 100
            self.view.layoutIfNeeded()
        }
        
        
        self.loadingLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 32 : 24,style: .semiBold)
        self.internetConnectionLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 32 : 24,style: .semiBold)
        self.okInternetButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 24,style: .semiBold)
        self.okInternetButton.layer.cornerRadius = IS_IPAD ? 44 : 26
        self.intenetConnectionView.layer.cornerRadius = IS_IPAD ? 44 : 26
        
        self.setupProgressView()
        self.fetchDataFromDropbox()
    }
    
    @IBAction func okInternetButton(_ sender: Any) {
        self.fetchDataFromDropbox()
    }
    
    func setupProgressView() {
        self.leanerarProgressView.layer.cornerRadius = IS_IPAD ? 35 : 20
        self.leanerarProgressView.cornerRadius = IS_IPAD ? 35 : 20
        self.leanerarProgressView.clipsToBounds = true
        self.leanerarProgressView.barColor = UIColor(named: "newblackcolorfounded")!
        self.leanerarProgressView.borderColor = UIColor(named: "lightercoloruidrag")!
        self.leanerarProgressView.borderWidth = IS_IPAD ? 8 : 4
        self.leanerarProgressView.spacing = 0
        self.leanerarProgressView.innerSpacing = 0
        self.leanerarProgressView.progress = 0 // Initial progress
    }
    
    func noInternetFound(_ isBool: Bool) {
        self.connectionView.isHidden = !isBool
        self.loadingLabel.isHidden = isBool
        self.leanerarProgressView.isHidden = isBool
    }
    
//    func updateProgress() {
//        
//        let progressPercentage = CGFloat(completedFiles) / CGFloat(totalFiles)
////        self.leanerarProgressView.progress = progressPercentage
//        UIView.animate(withDuration: 0.3) {
//            self.leanerarProgressView.progress = progressPercentage
//        }
//        
//        UIView.animate(withDuration: 0.5, // Slow down the animation to half a second
//                           delay: 0, // No delay
//                           options: [.curveEaseInOut], // Smooth ease-in, ease-out animation
//                           animations: {
//                self.leanerarProgressView.progress = progressPercentage
//            }, completion: nil)
//        
//        if progressPercentage >= 1.0 {
//            self.leanerarProgressView.percentageLabel.textColor = UIColor(named: "lightercoloruidrag")
//        }
//    }
    
    func updateProgress() {
        let progressPercentage = CGFloat(self.elapsedTime) / CGFloat(self.maxDuration)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.leanerarProgressView.progress = progressPercentage
        }, completion: nil)
        
        if progressPercentage >= 1.0 {
            self.leanerarProgressView.percentageLabel.textColor = UIColor(named: "lightercoloruidrag")
        }
    }
    
    private func startProgressTimer() {
        self.timer?.invalidate() // Invalidate any existing timer
        self.elapsedTime = 0 // Reset elapsed time
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.elapsedTime += 0.1
            
            if self.elapsedTime <= self.maxDuration {
                self.updateProgress()
                
                guard InternetManager_AW.shared.checkInternetConnectivity_AW() else {
                    self.noInternetFound(true)
                    self.timer?.invalidate()
                    self.timer = nil
                    self.leanerarProgressView.progress = 0.0
                    return
                }
                
            } else {
                self.timer?.invalidate()
                self.timer = nil
                self.updateProgress()
                self.transition?.didEndUploading()
            }
        }
    }
    
    // Dropbox Data Fetching
    func fetchDataFromDropbox() {
        guard InternetManager_AW.shared.checkInternetConnectivity_AW() else {
            self.noInternetFound(true)
            return
        }
        
        self.noInternetFound(false)
        
        DBManager_AW.shared.connect_AW { client in
            
            guard client != nil else {
                print("Failed to connect to Dropbox")
                return
            }
            
            filesPath.removeAll()
            self.saveTotalFoldersName {
                print("All folder names fetched. Now performing the next action.")
                self.findAllFoldersContentsCount()
                
                
                self.downloadJsonFile("/content/66ebf80676cb8/content.json", "content.json", folderName: "66ebf80676cb8")
                self.downloadJsonFile("/content/66ebf80c744ca/content.json", "content.json", folderName: "66ebf80c744ca")
                self.downloadJsonFile("/content/66ebf80665d2f/content.json", "content.json", folderName: "66ebf80665d2f")
                
                DBManager_AW.shared.listFolder_AW(path: "/content/66ebf80676cb8") { result in
                    switch result {
                    case .success(let folderContents):
                        for file in folderContents {
                            if file.isFolder {
                                
                            } else {
                                if file.name.hasSuffix(".png") {
                                    
                                    self.downloadImageFile(file.path, file.name, folderName: "66ebf80676cb8")
                                }
                            }
                        }
                        
                    case .failure(let error):
                        print("Failed to fetch folder contents: \(error.localizedDescription)")
                        
                    }
                }
                
                if UserDefaults.isFirstOnboardCompleted == false {
                    var folderPath = "/content/66ebf80c744ca"
                    DBManager_AW.shared.listFolder_AW(path: folderPath) { result in
                        
                        self.startProgressTimer()
                        
                        switch result {
                        case .success(let folderContents):
                            for file in folderContents {
                                if file.isFolder {
                                    
                                } else {
                                    if file.name.hasSuffix(".png") {
                                        self.downloadImageFile(file.path, file.name, folderName: "66ebf80c744ca")
                                    }
                                }
                            }
                            
                            
                        case .failure(let error):
                            print("Failed to fetch folder contents: \(error.localizedDescription)")
                            
                        }
                    }
                    
                    folderPath = "/content/66ebf80665d2f"
                    DBManager_AW.shared.listFolder_AW(path: folderPath) { result in
                        switch result {
                        case .success(let folderContents):
                            for file in folderContents {
                                if file.isFolder {
                                    
                                } else {
                                    if file.name.hasSuffix(".png") {
                                        self.downloadImageFile(file.path, file.name, folderName: "66ebf80665d2f")
                                    }
                                }
                            }
                            
//                            folderPath = "/content/66ebf80676cb8"
//                            DBManager_AW.shared.listFolder_AW(path: folderPath) { result in
//                                switch result {
//                                case .success(let folderContents):
//                                    for file in folderContents {
//                                        if file.isFolder {
//                                            
//                                        } else {
//                                            if file.name.hasSuffix(".png") {
//                                                self.downloadImageFile(file.path, file.name, folderName: "66ebf80676cb8")
//                                            }
//                                        }
//                                    }
//                                    
//                                case .failure(let error):
//                                    print("Failed to fetch folder contents: \(error.localizedDescription)")
//                                    
//                                }
//                            }
                            
                        case .failure(let error):
                            print("Failed to fetch folder contents: \(error.localizedDescription)")
                            
                        }
                    }
                } else {
                    self.maxDuration = 5.0 // 12.0
                    self.startProgressTimer()
                }
            }
        }
    }
    
    func saveTotalFoldersName(completion: @escaping () -> Void) {
//        let dispatchGroup = DispatchGroup()

        DBManager_AW.shared.listFolder_AW(path: "/content") { result in
            switch result {
            case .success(let folderContents):
                for file in folderContents {
                    if file.isFolder {
//                        dispatchGroup.enter()
                        totalFoldersInDropbox.append(file.name)
                        filesPath.append(URL(string: "\(self.localFolderPath + "/" + file.name)")!)
                    }
                }
                
//                dispatchGroup.notify(queue: .main) {
                    completion()
//                }
            case .failure(let error):
                print("Failed to fetch folder contents: \(error.localizedDescription)")
//                dispatchGroup.notify(queue: .main) {
                    completion()
//                }
            }
        }
    }
    
    func findAllFoldersContentsCount(index: Int = 0) {
        guard index < totalFoldersInDropbox.count else {
            
            self.filteredFiles = foldersFiles.filter { specificFolders.contains($0.folderName) }
//            self.downloadFoldersContentOneByOne()
            return
        }
        
        let folderPath = "/content/\(totalFoldersInDropbox[index])"
        DBManager_AW.shared.listFolder_AW(path: folderPath) { result in
            switch result {
            case .success(let folderContents):
                for file in folderContents {
                    if file.isFolder {
                    } else {
                        if file.name.hasSuffix(".json") || file.name.hasSuffix(".png") {
                            foldersFiles.append(DropboxFileContent(folderName: totalFoldersInDropbox[index], fileName: file.name))
                        }
                    }
                }
                
                self.findAllFoldersContentsCount(index: index + 1)
                
            case .failure(let error):
                print("Failed to fetch folder contents: \(error.localizedDescription)")
                
                self.findAllFoldersContentsCount(index: index + 1)
            }
        }
    }
    
    func downloadFoldersContentOneByOne(index: Int = 0) {
        guard index < 2 else {
            return
        }
        
        let folderPath = "/content/\(totalFoldersInDropbox[index])"
        DBManager_AW.shared.listFolder_AW(path: folderPath) { result in
            switch result {
            case .success(let folderContents):
                for file in folderContents {
                    if file.isFolder {
                        
                    } else {
                        if file.name.hasSuffix(".png") {
                            self.downloadImageFile(file.path, file.name, folderName: totalFoldersInDropbox[index])
                        } else if file.name.hasSuffix(".json") {
                            self.downloadJsonFile(file.path, file.name, folderName: totalFoldersInDropbox[index])
                        }
                    }
                }
               
                self.downloadFoldersContentOneByOne(index: index + 1)
                
            case .failure(let error):
                print("Failed to fetch folder contents: \(error.localizedDescription)")
                
                self.downloadFoldersContentOneByOne(index: index + 1)
            }
        }
    }
    
//    func downloadImageFile(_ filePath: String, _ name: String) {
//        DBManager_AW.shared.downloadFile_AW(path: filePath) { result in
//            switch result {
//            case .success(let imageData):
//                if UIImage(data: imageData) != nil {
//                    if let savedPath = self.saveImageToDevice(imageData, fileName: name) {
//                        print("\nImage file saved at: \(savedPath)\n")
//                    }
//                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        self.completedFiles += 1
//                        self.updateProgress()
//                        
//                        if self.totalFiles == self.completedFiles {
//                            self.transition?.didEndUploading()
//                        }
//                    }
//                } else {
//                    print("Failed to convert data to image")
//                }
//            case .failure(let error):
//                print("Failed to download image file: \(error.localizedDescription)")
//            }
//        }
//    }
    
    // Save image data to the device
//    func saveImageToDevice(_ data: Data, fileName: String) -> String? {
//        let fileManager = FileManager.default
//        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
////            print("Failed to access document directory")
//            return nil
//        }
//        
//        let fileURL = documentsDirectory.appendingPathComponent(fileName)
//        
//        do {
//            try data.write(to: fileURL)
//            filesPath.append(fileURL)
//            return fileURL.path
//        } catch {
//            print("Failed to save image file: \(error.localizedDescription)")
//            return nil
//        }
//    }
    
//    func downloadJsonFile(_ filePath: String,_ name: String) {
//        DBManager_AW.shared.downloadFile_AW(path: filePath) { result in
//            switch result {
//            case .success(let jsonData):
//                if let jsonString = String(data: jsonData, encoding: .utf8) {
//                    print("================  \(name)  =================")
////                    print("Downloaded JSON content: \n\(jsonString)")
//                    print("================  END  ================")
//                }
//                
//                if let savedPath = self.saveJsonToDevice(jsonData, fileName: name) {
////                    print("\nJSON file saved at: \(savedPath)\n")
//                }
//                
//                // Update progress
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1-second delay for demonstration
//                    // Update progress
//                    self.completedFiles += 1
//                    self.updateProgress()
//                    
//                    if self.totalFiles == self.completedFiles {
//                        self.transition?.didEndUploading()
//                    }
//                }
//            case .failure(let error):
//                print("Failed to download JSON file: \(error.localizedDescription)")
//            }
//        }
//    }
    
//    func saveJsonToDevice(_ data: Data, fileName: String) -> String? {
//        let fileManager = FileManager.default
//        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("Failed to access document directory")
//            return nil
//        }
//        
//        let fileURL = documentsDirectory.appendingPathComponent(fileName)
//        
//        do {
//            try data.write(to: fileURL)
//            filesPath.append(fileURL)
//            return fileURL.path
//        } catch {
//            print("Failed to save file: \(error.localizedDescription)")
//            return nil
//        }
//    }
}


extension UIViewController {
    
    func saveImageToDevice(_ data: Data, fileName: String, folderName: String) -> String? {
        let fileManager = FileManager.default
        let folderPath = localFolderPath + "/\(folderName)"
        
        if !fileManager.fileExists(atPath: folderPath) {
            do {
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create directory: \(error.localizedDescription)")
                return nil
            }
        }
        
        let fileURL = URL(fileURLWithPath: folderPath).appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Failed to save image file: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveJsonToDevice(_ data: Data, fileName: String, folderName: String) -> String? {
        let fileManager = FileManager.default
        let folderPath = localFolderPath + "/\(folderName)"
        
        if !fileManager.fileExists(atPath: folderPath) {
            do {
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create directory: \(error.localizedDescription)")
                return nil
            }
        }
        
        let fileURL = URL(fileURLWithPath: folderPath).appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            
            return fileURL.path
        } catch {
            print("Failed to save JSON file: \(error.localizedDescription)")
            return nil
        }
    }
    
    func downloadImageFile(_ filePath: String, _ name: String, folderName: String) {
        if !self.fileExists(at: localFolderPath + "/" + folderName + "/" + name) {
            
            DBManager_AW.shared.downloadFile_AW(path: filePath) { result in
                switch result {
                case .success(let imageData):
                    if UIImage(data: imageData) != nil {
                        if let savedPath = self.saveImageToDevice(imageData, fileName: name, folderName: folderName) {
                            print("\nImage file saved at: \(savedPath)\n")
                        }
                        
                    } else {
                        print("Failed to convert data to image")
                    }
                case .failure(let error):
                    print("Failed to download image file: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fileExists(at path: String) -> Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: path)
    }
    
    func downloadJsonFile(_ filePath: String, _ name: String, folderName: String) {
        if !self.fileExists(at: localFolderPath + "/" + folderName + "/" + name) {
            
            DBManager_AW.shared.downloadFile_AW(path: filePath) { result in
                switch result {
                case .success(let jsonData):
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("================  \(name)  =================")
                        print("================  END  ================")
                    }
                    
                    if let savedPath = self.saveJsonToDevice(jsonData, fileName: name, folderName: folderName) {
                        print("\nJSON file saved at: \(savedPath)\n")
                        
                        if name == "66ebf80676cb8" {
                            self.fetchAllDataForSkinMaker()
                        }
                    }
                    
                case .failure(let error):
                    print("Failed to download JSON file: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchAllDataForSkinMaker() {
        let jsonFilePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + "content.json"
        
        if let files: EditorContent = FileSession_AW.shared.getModelFromFile_AW(from: URL(fileURLWithPath: jsonFilePath)) {
            
            self.appendStrokes(for: "Shoes", from: files.z3D.shoes)
            self.appendStrokes(for: "Eyes", from: files.z3D.eyes)
            self.appendStrokes(for: "Body", from: files.z3D.body)
            self.appendStrokes(for: "Mouth", from: files.z3D.mouth)
            self.appendStrokes(for: "Clothes", from: files.z3D.clothes)
            self.appendStrokes(for: "Hair", from: files.z3D.hair)
            self.appendStrokes(for: "Brows", from: files.z3D.brows)
            self.appendStrokes(for: "Headdress", from: files.z3D.headdress)
            self.appendStrokes(for: "Face", from: files.z3D.face)
            self.appendStrokes(for: "Accessory", from: files.z3D.accessory)
        }
    }
    
    private func appendStrokes(for type: String, from data: [String: Accessory]) {
        for (_, value) in data {
            let stroke = CustomEditorStroke(type: type, data: value)
            
            let originalImagePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + "\(stroke.data.imageOriginal)"
            let editorContentOriginalImgData = self.loadImageFromFile(at: originalImagePath)
            if editorContentOriginalImgData.isEmpty {
                self.downloadImageFile("/content/66ebf80676cb8/\(stroke.data.imageOriginal)", "\(stroke.data.imageOriginal)", folderName: "66ebf80676cb8")
                
            }
            
            let previewImagePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + "\(stroke.data.previewImage)"
            let editorContentPreviewImgData = self.loadImageFromFile(at: previewImagePath)
            
            if editorContentPreviewImgData.isEmpty {
                self.downloadImageFile("/content/66ebf80676cb8/\(stroke.data.previewImage)", "\(stroke.data.previewImage)", folderName: "66ebf80676cb8")
                
            }
        }
    }
}
