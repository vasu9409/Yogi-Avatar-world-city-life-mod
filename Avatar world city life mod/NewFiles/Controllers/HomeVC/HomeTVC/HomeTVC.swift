//
//  HomeTVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import UIKit

class HomeTVC: UITableViewCell {
    
    
    @IBOutlet weak var homeContainerBaseViewHope: UIView!
    @IBOutlet weak var avatarKiteImageWarning: UIImageView!
    @IBOutlet weak var nameAvtarCellChipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.homeContainerBaseViewHope.layer.cornerRadius = IS_IPAD ? 38 : 20
        self.nameAvtarCellChipLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
    }
    
    func changeColors() {
        if checkIsDarkMode() {
            self.homeContainerBaseViewHope.backgroundColor = UIColor(named: "")
            self.avatarKiteImageWarning.tintColor = UIColor(named: "")
            self.nameAvtarCellChipLabel.textColor = UIColor(named: "")
        } else {
            self.homeContainerBaseViewHope.backgroundColor = UIColor(named: "")
            self.avatarKiteImageWarning.tintColor = UIColor(named: "")
            self.nameAvtarCellChipLabel.textColor = UIColor(named: "")
        }
    }
}
