//
//  LockScreenView.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//

import UIKit

class LockScreenView: UIViewBase {

    @IBOutlet weak var lockImageView: UIImageView!
    
    var isDark: Bool = false {
        didSet {
            self.lockImageView.image = UIImage(named: self.isDark ? "darkKnightLocksDots" : "greenLockDocsPermanent")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyBlur(self.contentView, isBlack: false)
    }
}
