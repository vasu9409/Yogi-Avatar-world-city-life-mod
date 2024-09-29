//
//  ContentTableViewCell.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

protocol ContentTableViewCellDelegate_AW: AnyObject {
    func makeIsFavorite_AW(with model: ListDTO_AW)
}

class ContentTableViewCell_AW: UITableViewCell, Reusable_AW {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    private var model: ListDTO_AW!
    weak var delegate: ContentTableViewCellDelegate_AW?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLbl.textColor = .black
        titleLbl.numberOfLines = 2
        contentImageView.roundCorners_AW(radius: 24)
        checkmarkButton.addTarget(self, action: #selector(checkmarkButtonTapped_AW), for: .touchUpInside)
        
        bgView.addBorder_AW(color: .white, width: 1.5)
        bgView.backgroundColor = .white.withAlphaComponent(0.1)
        layerView.backgroundColor = .white
        bgView.roundCorners_AW(radius: 24)
        layerView.roundCorners_AW(radius: 24)
        layerView.addBorder_AW(color: Colors_AW.contentBorderColor, width: 3)
    }
    
    func configure_AW(with model: ListDTO_AW) {
        self.model = model
        titleLbl.text = model.name
        descriptionLbl.text = model.description
        if let imageData = model.data {
            contentImageView.image = UIImage(data: imageData)

        }
        checkmarkButton.setBackgroundImage(model.isFavorite ? UIImage(named: "button_checkmark") : UIImage(named: "button_checkmark_inactive"), for: .normal)
    }
    
    @objc private func checkmarkButtonTapped_AW() {
       
        delegate?.makeIsFavorite_AW(with: model)
    }
    
}
