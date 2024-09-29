//
//  TabBarButton_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

@IBDesignable

class TabBarButton_AW: UIView {
    @IBOutlet weak var tabImageView: UIImageView!
    @IBOutlet weak var tabTitle: UILabel!
    @IBOutlet weak var coronImg: UIImageView!
    
    @IBInspectable var isSelected: Bool = false {
        didSet {
            let color: UIColor = isSelected ? Colors_AW.tabBarActiveColor :  Colors_AW.tabBarInactiveColor
            tabTitle.textColor = color
            tabImageView.tintColor = color
        }
    }
    var onClick: (TabBarButton_AW) -> Void = { _ in }
    
    var item: TabBarItem_AW = .home {
        didSet {
            tabTitle.text = item.title
            tabImageView.image = item.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize_AW()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize_AW()
    }
    
    private func initialize_AW() {
        nibSetup_AW()
        
        coronImg.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap_AW))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        
        tabTitle.font = Fonts_AW.balooFont_AW(size: 12)
    }
    
    @objc
    private func handleTap_AW() {
       
        
        onClick(self)
    }
}


