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

class PreloaderVC: UIViewController {
    
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var internetConnectionLabel: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var leanerarProgressView: LinearProgressBar!
    @IBOutlet weak var okInternetButton: UIButton!
    @IBOutlet weak var intenetConnectionView: UIView!
    
    weak var transition: PreloaderViewControllerTransition?
    private var totalFiles: Int = 0
    private var completedFiles: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.connectionView.isHidden = true
        self.loadingLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 24,style: .semiBold)
        self.internetConnectionLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 24,style: .semiBold)
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
        self.leanerarProgressView.borderWidth = IS_IPAD ? 4 : 7
        self.leanerarProgressView.spacing = 0
        self.leanerarProgressView.innerSpacing = 0
        self.leanerarProgressView.progress = 0 // Initial progress
    }
    
    func noInternetFound(_ isBool: Bool) {
        self.connectionView.isHidden = !isBool
        self.loadingLabel.isHidden = isBool
        self.leanerarProgressView.isHidden = isBool
    }
    
    func updateProgress() {
        
        let progressPercentage = CGFloat(completedFiles) / CGFloat(totalFiles)
//        self.leanerarProgressView.progress = progressPercentage
        UIView.animate(withDuration: 0.3) {
            self.leanerarProgressView.progress = progressPercentage
        }
        
        UIView.animate(withDuration: 0.5, // Slow down the animation to half a second
                           delay: 0, // No delay
                           options: [.curveEaseInOut], // Smooth ease-in, ease-out animation
                           animations: {
                self.leanerarProgressView.progress = progressPercentage
            }, completion: nil)
        
        if progressPercentage >= 1.0 {
            self.leanerarProgressView.percentageLabel.textColor = UIColor(named: "lightercoloruidrag")
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
//            self.fetchModel_AW()
            let folderPath = "/content"
            self.fetchFolderContents(folderPath, client!)
        }
    }
    
    func fetchFolderContents(_ folderPath: String,_ client: DropboxClient) {
        DBManager_AW.shared.listFolder_AW(path: folderPath) { result in
            switch result {
            case .success(let folderContents):
                self.totalFiles = folderContents.count - 1
                for i in folderContents {
                    self.downloadJsonFile(i.path + "/content.json", i.name)
                }
                
            case .failure(let error):
                print("Failed to fetch folder contents: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchModel_AW() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if DBManager_AW.shared.isAllModelsUploaded_AW() {
            dispatchGroup.leave()
        } else {
            DBManager_AW.shared.fetchModel_AW {
                dispatchGroup.leave()
                print("🔴 fetching model")
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("fetching model content...")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.navigateToMainMenu_AW()
            }
        }
    }
    
    func downloadJsonFile(_ filePath: String,_ name: String) {
        DBManager_AW.shared.downloadFile_AW(path: filePath) { result in
            switch result {
            case .success(let jsonData):
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("================  \(name)  =================")
//                    print("Downloaded JSON content: \n\(jsonString)")
                    print("================  END  ================")
                }
                
                if let savedPath = self.saveJsonToDevice(jsonData, fileName: name) {
//                    print("\nJSON file saved at: \(savedPath)\n")
                }
                
                // Update progress
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1-second delay for demonstration
                    // Update progress
                    self.completedFiles += 1
                    self.updateProgress()
                    
                    if self.totalFiles == self.completedFiles {
                        self.transition?.didEndUploading()
                    }
                }
            case .failure(let error):
                print("Failed to download JSON file: \(error.localizedDescription)")
            }
        }
    }
    
    func saveJsonToDevice(_ data: Data, fileName: String) -> String? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to access document directory")
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            filesPath.append(fileURL)
            return fileURL.path
        } catch {
            print("Failed to save file: \(error.localizedDescription)")
            return nil
        }
    }
}


