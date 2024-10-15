//
//  HomeVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import Applio
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newHomeNavigationArrangedTitle: UILabel!
    
    var homeSecurityArrayOFObjects: [String] = ["modsJarsetup", "houseIdeasMadeButton", "rocketcrashdownside", "exportSettingWheelDot"]
    var homeFoundNameArrNews: [String] = ["Mods", "House ideas", "Skin maker", "Settings"]
    
    private var dropbox: DBManager_AW { .shared }
    var isLockedCell: Bool = false
    let viewModel: EditorSetupViewModel_AW = EditorSetupViewModel_AW()
    var characterPriviewModel_AW: CharacterPriviewModel_AW?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadContent_AW(with: self.dropbox.contentManager.fetchEditorContent_AW())
        viewModel.makeSelected_AW(type: .body)
        
        self.setupUI()
        self.setupTableView()
        self.isLockedCell = false
        
        guard let preview = characterPriviewModel_AW else { return }
        viewModel.loadSelectedContent_AW(with: preview.content)
        
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


