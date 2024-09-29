//
//  CategoryCollectionViewCell.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
    }
    
    func configure_AW(with model: EditorCategoryDataModel_AW) {
        categoryLabel.textColor = model.isSelected ? #colorLiteral(red: 0.9607843137, green: 0.3882352941, blue: 0.6823529412, alpha: 1) : #colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)
        categoryLabel.text = model.type.localizedTitle
    }
}
