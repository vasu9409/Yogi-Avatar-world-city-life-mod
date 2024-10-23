//
//  SkinMakerVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//

import UIKit

class SkinMakerVC: UIViewController {

    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var AddNewButton: UIButton!
    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var btnVerificationView: UIView!
    @IBOutlet weak var btnPreviewView: UIView!
    @IBOutlet weak var noskinaddedButton: UIButton!
    @IBOutlet weak var addNewSkinButton: UIButton!
    @IBOutlet weak var newxtButton: UIView!
    @IBOutlet weak var previeouseButotn: UIView!
    
    var isShowVerification: Bool = false {
        didSet {
            self.btnPreviewView.isHidden = self.isShowVerification
            self.btnVerificationView.isHidden = !self.isShowVerification
        }
    }
    
    var skinAdded: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isShowVerification = (self.skinAdded.count == 0)
        
        self.largeTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
        self.AddNewButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        self.noskinaddedButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        self.addNewSkinButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        
        self.setupUI()
        
        
        
        
        
        
    }
    
    @IBAction func btnAddSkin(_ sender: Any) {
        let ctrl = SkinMakerPreviewVC()
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    @IBAction func btnNoSkinAdd(_ sender: Any) {
        
    }
    
    @IBAction func btnRight(_ sender: Any) {
        
    }
    
    @IBAction func btnLeft(_ sender: Any) {
        
    }
    
    @IBAction func btnAddNew(_ sender: Any) {
        let ctrl = SkinMakerPreviewVC()
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        self.AddNewButton.layer.cornerRadius = IS_IPAD ? 44 : 26
        self.noskinaddedButton.layer.cornerRadius = IS_IPAD ? 44 : 26
        self.addNewSkinButton.layer.cornerRadius = IS_IPAD ? 44 : 26
        
        self.backButtonView.layer.cornerRadius = IS_IPAD ? 42 : 25
        self.newxtButton.layer.cornerRadius = IS_IPAD ? 42 : 25
        self.previeouseButotn.layer.cornerRadius = IS_IPAD ? 42 : 25
        
        self.btnPreviewView.layer.cornerRadius = IS_IPAD ? 44 : 26
        self.btnVerificationView.layer.cornerRadius = IS_IPAD ? 44 : 26
    }
}
