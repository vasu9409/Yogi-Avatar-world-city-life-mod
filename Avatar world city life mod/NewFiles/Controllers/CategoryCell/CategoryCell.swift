//
//  CategoryCollectionViewCell.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var catNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.catNameLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
    }
    
    func selected(_ isBool: Bool) {
        if isBool {
            self.backView.backgroundColor = AppColors.blackColor
            self.catNameLabel.textColor = AppColors.whiteColor
        } else {
            self.backView.backgroundColor = AppColors.englishColor
            self.catNameLabel.textColor = AppColors.blackColor
        }
    }
}
