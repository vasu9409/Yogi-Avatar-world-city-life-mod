//
//  HouseIdeasCell.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//

import UIKit

class HouseIdeasCell: UICollectionViewCell {

    @IBOutlet weak var ideaTitleName: UILabel!
    @IBOutlet weak var cellImageVIew: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var mainBGView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainBGView.layer.cornerRadius = IS_IPAD ? 52 : 18
        self.cellImageVIew.layer.cornerRadius = IS_IPAD ? 52 : 18
        self.heartButton.layer.cornerRadius = IS_IPAD ? 41 : 24
    }
    
    @IBAction func heartButton(_ sender: Any) {
        
    }
    
}
