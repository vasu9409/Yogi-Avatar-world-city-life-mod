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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupTableView()
    }
    
    private func setupUI() {
        self.newHomeNavigationArrangedTitle.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 42 : 24, style: .bold)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IS_IPAD ? 88 : 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let ctrl = ModsVCViewController(nibName: "ModsVCViewController", bundle: nil)
            ctrl.isForMods = true
            self.navigationController?.pushViewController(ctrl, animated: true)
            
            break
            
        case 1:
            let ctrl = ModsVCViewController(nibName: "ModsVCViewController", bundle: nil)
            ctrl.isForMods = false
            self.navigationController?.pushViewController(ctrl, animated: true)
            
            break
            
        case 2:
            let ctrl = ModsVCViewController(nibName: "ModsVCViewController", bundle: nil)
            self.navigationController?.pushViewController(ctrl, animated: true)
            
            break
            
        case 3:
            let ctrl = SettingsVC(nibName: "SettingsVC", bundle: nil)
            self.navigationController?.pushViewController(ctrl, animated: true)
            
            break
            
        default : break
            
        }
    }
}
