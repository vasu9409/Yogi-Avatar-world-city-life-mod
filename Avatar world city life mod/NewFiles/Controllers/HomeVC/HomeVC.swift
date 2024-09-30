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
    }
    
    private func setupUI() {
//        self.newHomeNavigationArrangedTitle.font =
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as? HomeTVC else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
