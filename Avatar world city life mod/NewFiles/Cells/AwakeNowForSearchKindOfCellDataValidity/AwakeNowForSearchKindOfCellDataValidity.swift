//
//  SearchCell.swift
//  Avatar world city life mod
//
//  Created by Mac Mini on 13/10/24.
//

import UIKit

class AwakeNowForSearchKindOfCellDataValidity: UITableViewCell {

    @IBOutlet weak var seachBgView: UIView!
    @IBOutlet weak var seachNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.seachNameLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 28 : 18 , style: .semiBold)
        self.seachBgView.layer.cornerRadius = IS_IPAD ? 37 : 22
    }
}
