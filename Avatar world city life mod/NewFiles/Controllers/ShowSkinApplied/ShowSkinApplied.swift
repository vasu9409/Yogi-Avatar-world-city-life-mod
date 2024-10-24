//
//  ShowSkinApplied.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 24/10/24.
//

import RealmSwift
import UIKit

class ShowSkinApplied: UIViewController {
    
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var largeTitleLabel: UILabel!
    
    @IBOutlet weak var downloadingLinearView: LinearProgressBar!
    
    @IBOutlet weak var btnPreviewView: UIImageView!
    
    var selectedImage: UIImage?
    
    var dataImage: Data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.largeTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
        self.btnDownload.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 20, style: .bold)
        
        self.btnDownload.layer.cornerRadius = IS_IPAD ? 41 : 24
        self.downloadingLinearView.layer.cornerRadius = IS_IPAD ? 41 : 24
        
        self.downloadingLinearView.isHidden = true
        
        self.btnPreviewView.image = self.selectedImage
    }
    
    
    @IBAction func btnDownload(_ sender: Any) {
        
        
        guard let image = self.btnPreviewView.toImage() else { return }
        
        // Convert UIImage to PNG data
        guard let pngData = image.pngData() else { return }
        
        self.dataImage = pngData
        
        self.setupProgress()
        
        
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveImageToRealm() {
        var nameLabelText: String = ""
        
        do {
            
            let realm = try Realm()
            
            let newPerson = ListElementObject()
            newPerson.title = UUID().uuidString
            newPerson.contentType = "Skin"
            newPerson.data = self.dataImage
            try realm.write {
                realm.add(newPerson)
            }
            
            nameLabelText = "Download is successful"
            
            let ctrl = PopUPView()
            ctrl.nameLabelText = nameLabelText
            self.present(ctrl, animated: false, completion: nil)
            
        } catch {
            print(error)
            nameLabelText = "Download is failed"
            
            let ctrl = PopUPView()
            ctrl.nameLabelText = nameLabelText
            self.present(ctrl, animated: false, completion: nil)
        }
    }
    
    func setupProgress() {
        
        self.downloadingLinearView.layer.cornerRadius = IS_IPAD ? 23 : 13
        self.downloadingLinearView.barColor = UIColor(named: "newblackcolorfounded")!
        self.downloadingLinearView.borderColor = UIColor(named: "lightercoloruidrag")!
        self.downloadingLinearView.borderWidth = 3
        self.downloadingLinearView.spacing = 0
        self.downloadingLinearView.innerSpacing = 0
        
        let interval: TimeInterval = 0.02 // Small interval for smooth animation
        var elapsedTime: TimeInterval = 0
        let duration: TimeInterval = 7.0
        
        _ = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            elapsedTime += interval
            let progressPercentage = CGFloat(elapsedTime / duration)
            self.downloadingLinearView.progress = min(progressPercentage, 1.0)  // Cap the progress at 100%
            if self.downloadingLinearView.progress >= 0.5 {
                self.downloadingLinearView.percentageLabel.textColor = .white
            }
            
            if self.downloadingLinearView.progress >= 1.0 {
                timer.invalidate()  // Stop the timer when it reaches 100%
                
                self.saveImageToRealm()
            }
        }
    }
}