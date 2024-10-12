//
//  ModsTableCell.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import UIKit

class ModsTableCell: UITableViewCell {

    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var ArrowButton: UIButton!
    
    var isArrowButtonTapped: (() -> Void)?
    var isheartButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.ArrowButton.layer.cornerRadius = IS_IPAD ? 41 : 24
        self.mainView.layer.cornerRadius = IS_IPAD ? 52 : 18
        self.cellImageView.layer.cornerRadius = IS_IPAD ? 52 : 18
        self.heartButton.layer.cornerRadius = IS_IPAD ? 41 : 24
        
        // heartuncheckbroken - unfill heart
        // newStromheartStone - fill
    }
    
    @IBAction func arrowButton(_ sender: Any) {
        self.isArrowButtonTapped?()
    }
    
    @IBAction func heartButton(_ sender: Any) {
        self.isheartButtonTapped?()
    }
}
