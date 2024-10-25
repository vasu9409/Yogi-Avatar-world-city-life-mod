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
        
        
        self.view.isUserInteractionEnabled = false
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.view.isUserInteractionEnabled = true
            self.dismiss(animated: false)
            self.delegate?.didShowSkinApplied()
        }
    }
}
