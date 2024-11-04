//
//  SettingsVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 07/10/24.
//

import UIKit

class WearingNotSettingsForMyControllerAttached: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newHomeNavigationArrangedTitle: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    var settingsSecurityArrayOFNameObjects: [String] = ["Terms of use", "Privacy Policy"]
    var settingsFoundImagesArrNews: [String] = ["gloryoftermsfordocuments", "newlookprivacyGesture"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupTableView()
        
        self.menuButton.clipsToBounds = true
        self.menuButton.layer.cornerRadius = IS_IPAD ? 42 : 24
        self.newHomeNavigationArrangedTitle.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
    }
    
    @IBAction func menuButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupTableView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(for: "SettingsCell")
        self.tableView.separatorStyle = .none
        
    }

}

extension WearingNotSettingsForMyControllerAttached: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsSecurityArrayOFNameObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.nameAvtarCellChipLabel.text = self.settingsSecurityArrayOFNameObjects[indexPath.row]
        cell.avatarKiteImageWarning.image = UIImage(named: self.settingsFoundImagesArrNews[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IS_IPAD ? 88 : 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
//            let ctrl = TermsVC()
//            self.navigationController?.pushViewController(ctrl, animated: true)
            self.openURL("https://www.google.com")
            break
            
        case 1:
//            let ctrl = PrivacyVC()
//            self.navigationController?.pushViewController(ctrl, animated: true)
            self.openURL("https://www.yandex.com")
            break
            
        default : break
            
        }
    }
    
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
