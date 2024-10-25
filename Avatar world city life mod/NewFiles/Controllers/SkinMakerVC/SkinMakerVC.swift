//
//  SkinMakerVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//


import UIKit
import RealmSwift

class SkinMakerVC: UIViewController {
    

    @IBOutlet weak var deleteButton: UIView!
    @IBOutlet weak var imageSkinView: UIImageView!
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
    
    var savedSkins: [ListElementObject] = []
    
    var imageDataArray: [Data] = []
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isShowVerification = true
        
        self.largeTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
        self.AddNewButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        self.noskinaddedButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        self.addNewSkinButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        
        self.setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.clearAndFetchSkins()
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let ctrl = DeleteVC()
        ctrl.modalPresentationStyle = .overFullScreen
        ctrl.savedSkins = self.savedSkins[self.currentIndex]
        self.present(ctrl, animated: false)
    }
    
    @IBAction func btnAddSkin(_ sender: Any) {
        let ctrl = SkinMakerPreviewVC()
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    @IBAction func btnNoSkinAdd(_ sender: Any) {

    }
    
    @IBAction func btnRight(_ sender: Any) {
        if currentIndex >= savedSkins.count - 1 {
            
        } else {
            self.currentIndex += 1
            self.imageSkinView.image = UIImage(data: self.imageDataArray[self.currentIndex])
        }
        
    }
    
    @IBAction func btnLeft(_ sender: Any) {
        if currentIndex <= 0 {
            
        } else {
            self.currentIndex -= 1
            self.imageSkinView.image = UIImage(data: self.imageDataArray[self.currentIndex])
        }
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
    
    func fetchAllSkinsData() {
        self.savedSkins.removeAll()
        do {
            let realm = try Realm()
            
            // Fetch all objects of type ListElementObject
            let allObjects = realm.objects(ListElementObject.self)
            
            
            for object in allObjects {
                
                self.savedSkins.append(object)
            }
        } catch {
            print("Error fetching data from Realm: \(error)")
        }

    }
    
    func clearAndFetchSkins() {
        self.savedSkins.removeAll()
        self.currentIndex = 0
        self.fetchAllSkinsData()
        self.isShowVerification = (self.savedSkins.count == 0)
        
        if self.savedSkins.count > 1 {
            
            self.newxtButton.isHidden = false
            self.previeouseButotn.isHidden = false
            
        } else {
            
            self.newxtButton.isHidden = true
            self.previeouseButotn.isHidden = true
            
        }
        
        self.deleteButton.isHidden = true
        
        if self.savedSkins.count > 0 {
            for imageData in self.savedSkins {
                self.imageDataArray.append(imageData.data ?? Data())
            }
            self.deleteButton.isHidden = false
            self.imageSkinView.image = UIImage(data: self.imageDataArray[self.currentIndex])
        }
    }
}
