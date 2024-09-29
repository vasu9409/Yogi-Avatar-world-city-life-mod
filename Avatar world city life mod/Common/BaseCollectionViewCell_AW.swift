//
//  BaseCollectionViewCell_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

class BaseCollectionViewCell_AW: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit_AW()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit_AW()
       
    }
    
    func commonInit_AW() {
        backgroundColor = .clear
    }
}
