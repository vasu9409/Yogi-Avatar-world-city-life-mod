//
//  SettingsViewController_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

class SettingsViewController_AW: BaseController_AW {

    @IBAction func privacyTapped(_ sender: Any) {
       
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func termsTapped(_ sender: Any) {
       
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
    }
    
}
