//
//  ContentCollectionViewCell.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var generallView: UIView!
    @IBOutlet weak var imgView: CachedImageView_AW!
    
    private var model: EditorContentDataModel_AW!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        generallView.layer.cornerRadius = 40
        generallView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 40
        imgView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configure_AW(with: self.model)
    }
    
    func configure_AW(with model: EditorContentDataModel_AW) {
        self.model = model
        if let data = model.previewImgData {
            imgView.getPdfImage_AW(with: data)
        } else {
            imgView.image = UIImage(named: "empty")
        }
        
        
        generallView.layer.borderColor = model.isSelected ? #colorLiteral(red: 0.9607843137, green: 0.3882352941, blue: 0.6823529412, alpha: 1).cgColor : UIColor.clear.cgColor
        generallView.layer.borderWidth = model.isSelected ? 1 : 0
    }
    

}
