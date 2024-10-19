//
//  HomeVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import Applio
import UIKit
import SwiftyDropbox

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newHomeNavigationArrangedTitle: UILabel!
    
    var homeSecurityArrayOFObjects: [String] = ["modsJarsetup", "houseIdeasMadeButton", "rocketcrashdownside", "exportSettingWheelDot"]
    var homeFoundNameArrNews: [String] = ["Mods", "House ideas", "Skin maker", "Settings"]
    
    private var dropbox: DBManager_AW { .shared }
    var isLockedCell: Bool = false
    let viewModel: EditorSetupViewModel_AW = EditorSetupViewModel_AW()
    var characterPriviewModel_AW: CharacterPriviewModel_AW?
    
    private var dropBox: DBManager_AW { .shared }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupTableView()
        self.isLockedCell = false
        
//        self.fetchDataFromDropbox()
    }
    
    func fetchDataFromDropbox() {
        DBManager_AW.shared.connect_AW { client in
            guard client != nil else {
                print("Failed to connect to Dropbox")
                return
            }
            
            let folderPath = "/content"
            self.fetchFolderContents(folderPath)
        }
    }
    
    func fetchFolderContents(_ folderPath: String) {
        DBManager_AW.shared.listFolder_AW(path: folderPath) { result in
            switch result {
            case .success(let folderContents):
                for i in folderContents {
                    self.downloadJsonFile(i.path + "/content.json", i.name)
                }
//                self.handleFolderContents(folderContents, parentPath: folderPath)
            case .failure(let error):
                print("Failed to fetch folder contents: \(error.localizedDescription)")
            }
        }
    }
    
    func downloadJsonFile(_ filePath: String,_ name: String) {
        DBManager_AW.shared.downloadFile_AW(path: filePath) { result in
            switch result {
            case .success(let jsonData):
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("================  \(name)  =================")
                    print("Downloaded JSON content: \n\(jsonString)")
                    print("================  END  ================")
                }
                
                if let savedPath = self.saveJsonToDevice(jsonData, fileName: name) {
                    print("\nJSON file saved at: \(savedPath)\n")
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
            
            return fileURL.path
        } catch {
            print("Failed to save file: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func setupUI() {
        self.newHomeNavigationArrangedTitle.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
    }
    
    private func setupTableView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(for: "HomeTVC")
        self.tableView.separatorStyle = .none
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeFoundNameArrNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as? HomeTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.nameAvtarCellChipLabel.text = self.homeFoundNameArrNews[indexPath.row]
        cell.avatarKiteImageWarning.image = UIImage(named: self.homeSecurityArrayOFObjects[indexPath.row])
        
        
        cell.lockView.isDark = true
        cell.setLock(self.isLockedCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IS_IPAD ? 88 : 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLockedCell {
            switch indexPath.row {
            case 0:
                let ctrl = ModsVCViewController()
                self.navigationController?.pushViewController(ctrl, animated: true)
                
                break
                
            case 1:
                let ctrl = HouseIdeasVC()
                self.navigationController?.pushViewController(ctrl, animated: true)
                
                break
                
            case 2:
                let ctrl = SkinMakerVC()
                self.navigationController?.pushViewController(ctrl, animated: true)
                
                break
                
            case 3:
                let ctrl = SettingsVC()
                self.navigationController?.pushViewController(ctrl, animated: true)
                
                break
                
            default : break
                
            }
        }
    }
}

struct DropboxFile {
    let name: String
    let isFolder: Bool
    let path: String
    
    init(entry: Files.Metadata) {
        self.name = entry.name
        self.isFolder = entry is Files.FolderMetadata
        self.path = entry.pathLower ?? ""
    }
}


extension DBManager_AW {
    
    func listFolder_AW(path: String, completion: @escaping (Result<[DropboxFile], Error>) -> Void) {
        client?.files.listFolder(path: path).response { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                let files = result.entries.map { DropboxFile(entry: $0) }
                completion(.success(files))
            }
        }
    }
    
    func downloadFile_AW(path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        client?.files.download(path: path).response { response, error in
            if let error = error {
                completion(.failure(error))
            } else if let response = response {
                completion(.success(response.1))
            }
        }
    }
}
