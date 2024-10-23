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
    @IBOutlet weak var downloadingView: LinearProgressBar!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    
    var modsDetailsMode: E8V?
    var detailsMode: The8Ua8Onb?
    var largeTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.largeTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
        self.detailDescriptionLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 28 : 16, style: .regular)
        self.detailTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 22, style: .semiBold)
        
        self.downloadButton.titleLabel?.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 34 : 22, style: .semiBold)
        
        self.scrollViewBGView.layer.cornerRadius = IS_IPAD ? 52 : 28
        self.downloadButton.layer.cornerRadius = IS_IPAD ? 41 : 24
        self.downloadingView.layer.cornerRadius = IS_IPAD ? 41 : 24
        self.detailImageView.layer.cornerRadius = IS_IPAD ? 52 : 24
        self.downloadingView.isHidden = true
        self.heartButton.layer.cornerRadius = IS_IPAD ? 41 : 24
        
//        https://stackoverflow.com/questions/67126979/how-to-animate-custom-progress-bar-properly-swift
        
        self.largeTitleLabel.text = self.largeTitle
        
        if let data = self.detailsMode {
            self.detailTitleLabel.text = data.title
            self.detailDescriptionLabel.text = data.description
            let imagePath = localFolderPath + "/" + ContentType_AW.houseIdeas.rawValue + "/" + data.the1477
            self.detailImageView.image = UIImage(data: self.loadImageFromFile(at: imagePath))
        }
        
        if let data = self.modsDetailsMode {
            self.detailTitleLabel.text = data.title
            self.detailDescriptionLabel.text = data.description
            let imagePath = localFolderPath + "/" + ContentType_AW.mod.rawValue + "/" + data.the00Ika
            self.detailImageView.image = UIImage(data: self.loadImageFromFile(at: imagePath))
        }
        
        self.heartButton.setImage(UIImage(named: "newStromheartStone"), for: .normal)
        self.heartButton.setImage(UIImage(named: "heartuncheckbroken"), for: .selected)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func heartButton(_ sender: Any) {
        
    }
    
    func setupProgress() {
        
        self.downloadingView.layer.cornerRadius = IS_IPAD ? 23 : 13
        self.downloadingView.barColor = UIColor(named: "newblackcolorfounded")!
        self.downloadingView.borderColor = UIColor(named: "lightercoloruidrag")!
        self.downloadingView.borderWidth = 3
        self.downloadingView.spacing = 0
        self.downloadingView.innerSpacing = 0
        
        let interval: TimeInterval = 0.02 // Small interval for smooth animation
        var elapsedTime: TimeInterval = 0
        let duration: TimeInterval = 7.0
        _ = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            elapsedTime += interval
            let progressPercentage = CGFloat(elapsedTime / duration)
            self.downloadingView.progress = min(progressPercentage, 1.0)  // Cap the progress at 100%
            if self.downloadingView.progress >= 0.5 {
                self.downloadingView.percentageLabel.textColor = .white
            }
            
            if self.downloadingView.progress >= 1.0 {
                timer.invalidate()  // Stop the timer when it reaches 100%
            }
        }
    }
}
