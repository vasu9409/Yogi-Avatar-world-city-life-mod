//
//  PrivacyVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//

import UIKit

class PrivacyVC: UIViewController {
    
    @IBOutlet weak var scrollBGView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var termsTitleLabel: UILabel!
    @IBOutlet weak var termsDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.backButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 22, style: .semiBold)
        self.largeTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
        self.termsTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 22, style: .semiBold)
        self.termsDetailLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 28 : 16, style: .regular)
        
        self.scrollBGView.layer.cornerRadius = IS_IPAD ? 46 : 24
        self.backButton.layer.cornerRadius = IS_IPAD ? 42 : 25
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
