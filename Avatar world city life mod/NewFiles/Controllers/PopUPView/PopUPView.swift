//
//  PopUPView.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 09/10/24.
//

import UIKit
import Blurberry

class PopUPView: UIViewController {

    @IBOutlet weak var nameBackView: UIView!
    @IBOutlet weak var popupnameLabel: UILabel!
    
    weak var delegate: ShowSkinAppliedVCDelegate?
    var nameLabelText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameBackView.layer.cornerRadius = IS_IPAD ? 44 : 24
        applyBlur(self.view)
        
        self.popupnameLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 32 : 20, style: .bold)
        
        self.popupnameLabel.text = self.nameLabelText
        
        
        self.dismiss(animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.delegate?.didShowSkinApplied()
        })
        
    }
}
