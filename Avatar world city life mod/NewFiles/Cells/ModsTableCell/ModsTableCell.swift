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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.ArrowButton.layer.cornerRadius = IS_IPAD ? 52 : 26
        self.mainView.layer.cornerRadius = IS_IPAD ? 52 : 18
        self.cellImageView.layer.cornerRadius = IS_IPAD ? 52 : 18
        self.heartButton.layer.cornerRadius = self.heartButton.frame.height / 2
        
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func arrowButton(_ sender: Any) {
        
    }
    
    @IBAction func heartButton(_ sender: Any) {
        
    }
}
