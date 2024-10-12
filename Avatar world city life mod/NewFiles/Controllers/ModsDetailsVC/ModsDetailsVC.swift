//
//  ModsDetailsVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 09/10/24.
//

import UIKit

class ModsDetailsVC: UIViewController {
    
    @IBOutlet weak var scrollViewBGView: UIView!
    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var downloadingView: UIView!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.largeTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
        self.detailDescriptionLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 28 : 16, style: .regular)
        self.detailTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 22, style: .semiBold)
        
        self.downloadButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 22, style: .semiBold)
        
        self.scrollViewBGView.layer.cornerRadius = IS_IPAD ? 46 : 24
        self.downloadButton.layer.cornerRadius = IS_IPAD ? 41 : 24
        self.downloadingView.layer.cornerRadius = IS_IPAD ? 41 : 24
        
        
        
//        https://stackoverflow.com/questions/67126979/how-to-animate-custom-progress-bar-properly-swift
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
