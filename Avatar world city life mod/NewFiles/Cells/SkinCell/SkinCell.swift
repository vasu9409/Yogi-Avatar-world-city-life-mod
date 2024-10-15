//
//  SkinCell.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 13/10/24.
//

import UIKit

class SkinCell: UICollectionViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.previewImageView.layer.cornerRadius = self.previewImageView.frame.width / 2
    }

}
