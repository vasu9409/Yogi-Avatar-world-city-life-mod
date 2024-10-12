//
//  HomeTVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import UIKit

class HomeTVC: UITableViewCell {
    
    @IBOutlet weak var lockView: LockScreenView!
    @IBOutlet weak var homeContainerBaseViewHope: UIView!
    @IBOutlet weak var avatarKiteImageWarning: UIImageView!
    @IBOutlet weak var nameAvtarCellChipLabel: UILabel!
    
    var isLockHide: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.homeContainerBaseViewHope.layer.cornerRadius = IS_IPAD ? 38 : 20
        self.lockView.layer.cornerRadius = IS_IPAD ? 38 : 20
        self.nameAvtarCellChipLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        self.lockView.clipsToBounds = true
        
    }
    
    func setLock(_ isBool: Bool) {
        self.lockView.isHidden = !isBool
        self.lockView.isUserInteractionEnabled = !isBool
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
