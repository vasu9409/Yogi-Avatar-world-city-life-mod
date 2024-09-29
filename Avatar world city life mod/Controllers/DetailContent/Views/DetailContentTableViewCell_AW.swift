//
//  DetailContentTableViewCell_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

protocol DetailContentDelegate_AW: AnyObject {
    func makeIsFavorite_AW(with model: ListDTO_AW)
}

class DetailContentTableViewCell_AW: UITableViewCell, Reusable_AW {
    
    private var model: ListDTO_AW!
    weak var delegate: DetailContentDelegate_AW?
    
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descrLbl: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.roundCorners_AW(radius: 24)
        bgView.addBorder_AW(color: .white, width: 1.5)
        bgView.backgroundColor = .white.withAlphaComponent(0.1)
        layerView.backgroundColor = .white
        bgView.roundCorners_AW(radius: 24)
        layerView.roundCorners_AW(radius: 24)
        layerView.addBorder_AW(color: Colors_AW.contentBorderColor, width: 3)
        
        checkmarkButton.addTarget(self, action: #selector(checkmarkButtonTapped_AW), for: .touchUpInside)
    }
    
    
    func configure_AW(with model: ListDTO_AW) {
        self.model = model
        
        if let imgData = model.data {
            imgView.image = UIImage(data: imgData)
        }
        
        let titleText = model.name ?? ""
        let descriptionText = model.description ?? ""
        
        checkmarkButton.setBackgroundImage(model.isFavorite ? UIImage(named: "button_checkmark") : UIImage(named: "button_checkmark_inactive"), for: .normal)

        let attributedString = NSMutableAttributedString(string: "\(titleText)\n\(descriptionText)")

        // Apply attributes for the title
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors_AW.titleColor,
            .font: Fonts_AW.defaultFont_AW(size: self.iPad ? 24 : 16)
        ]

        attributedString.addAttributes(titleAttributes, range: NSRange(location: 0, length: titleText.count))

        // Apply attributes for the description
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors_AW.descriptionColor,
            .font: Fonts_AW.interFont_AW(for: .regular, size: self.iPad ? 20: 14)
        ]

        attributedString.addAttributes(descriptionAttributes, range: NSRange(location: titleText.count + 1, length: descriptionText.count))

        descrLbl.attributedText = attributedString
    }
    
    @objc private func checkmarkButtonTapped_AW() {
       
        delegate?.makeIsFavorite_AW(with: self.model)
    }

    
}
