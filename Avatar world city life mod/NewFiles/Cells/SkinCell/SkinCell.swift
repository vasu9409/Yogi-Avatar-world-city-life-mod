//
//  SkinCell.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 13/10/24.
//

import UIKit

class SkinCell: UICollectionViewCell {

    @IBOutlet weak var skinImageBGView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.skinImageBGView.layer.cornerRadius = IS_IPAD ? 80 : 50
        self.previewImageView.layer.cornerRadius = IS_IPAD ? 80 : 50
    }

}
