//
//  SettingsCell.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 07/10/24.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var homeContainerBaseViewHope: UIView!
    @IBOutlet weak var avatarKiteImageWarning: UIImageView!
    @IBOutlet weak var nameAvtarCellChipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.homeContainerBaseViewHope.layer.cornerRadius = IS_IPAD ? 38 : 20
        self.nameAvtarCellChipLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
