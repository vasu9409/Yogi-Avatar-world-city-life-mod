//
//  CharacterEditorImage_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

final class CharacterEditorImage_AW: UIView {
    
    @IBOutlet weak var bodyImageView: CachedImageView_AW!
    @IBOutlet weak var shoesImageView: CachedImageView_AW!
    @IBOutlet weak var hairImageView: CachedImageView_AW!
    @IBOutlet weak var eyesImageView: CachedImageView_AW!
    @IBOutlet weak var noseImageView: CachedImageView_AW!
    @IBOutlet weak var eyebrowsImageView: CachedImageView_AW!
    @IBOutlet weak var mouthImageView: CachedImageView_AW!
    @IBOutlet weak var hatsImageView: CachedImageView_AW!
    @IBOutlet weak var shirtImageView: CachedImageView_AW!
    @IBOutlet weak var trousersImageView: CachedImageView_AW!
    @IBOutlet weak var hairsBack: CachedImageView_AW!

    
    var contents: [EditorContentDataModel_AW] = []
    private var dropbox: DBManager_AW {
        DBManager_AW.shared
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupUI_AW()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
        setupUI_AW()
    }
    
    private func setupUI_AW() {
//        self.nibSetup_AW()
        
       
    }
    
    func setupContents_AW(contents: [EditorContentDataModel_AW]) {
        self.contents = contents
        
        let selectedContents = contents.filter { $0.isSelected == true }
        
        selectedContents.forEach { [weak self] editorContent in
            switch editorContent.type {
            case .shoes:
                self?.shoesImageView.getPdfImage_AW(with: editorContent.imgData )
            case .hair:
                self?.hairImageView.getPdfImage_AW(with: editorContent.imgData )
            case .eyes:
                self?.eyesImageView.getPdfImage_AW(with: editorContent.imgData )
            case .nose:
                self?.noseImageView.getPdfImage_AW(with: editorContent.imgData )
            case .brows:
                self?.eyebrowsImageView.getPdfImage_AW(with: editorContent.imgData )
            case .mouth:
                self?.mouthImageView.getPdfImage_AW(with: editorContent.imgData )
            case .headdress:
                self?.hatsImageView.getPdfImage_AW(with: editorContent.imgData )
            case .top:
                self?.shirtImageView.getPdfImage_AW(with: editorContent.imgData )
            case .trousers:
                self?.trousersImageView.getPdfImage_AW(with: editorContent.imgData )
            case .body:
                self?.bodyImageView.getPdfImage_AW(with: editorContent.imgData )
            case .hairBack:
                self?.hairsBack.getPdfImage_AW(with: editorContent.imgData)
            }
        }
    }
    
   
    func changeStatus_AW(with content: EditorContentDataModel_AW) {
        if let index = self.contents.firstIndex(where: {$0.type == content.type}) {
            self.contents.remove(at: index)
            if self.contents.count < index {
                self.contents[index] = content
            }
        }
        
        switch content.type {
            
        case .shoes:
            self.shoesImageView.getPdfImage_AW(with: content.imgData )
        case .hair:
            self.hairImageView.getPdfImage_AW(with: content.imgData )
        case .eyes:
            self.eyesImageView.getPdfImage_AW(with: content.imgData )
        case .nose:
            self.noseImageView.getPdfImage_AW(with: content.imgData )
        case .brows:
            self.eyebrowsImageView.getPdfImage_AW(with: content.imgData )
        case .mouth:
            self.mouthImageView.getPdfImage_AW(with: content.imgData )
        case .headdress:
            self.hatsImageView.getPdfImage_AW(with: content.imgData )
        case .top:
            self.shirtImageView.getPdfImage_AW(with: content.imgData )
        case .trousers:
            self.trousersImageView.getPdfImage_AW(with: content.imgData )
        case .body:
            self.bodyImageView.getPdfImage_AW(with: content.imgData )
        case .hairBack:
            self.hairsBack.getPdfImage_AW(with: content.imgData)
        }
    }
    
    private func takeScreenshot_AW(of view: UIView) -> UIImage? {
       
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}

extension CharacterEditorImage_AW {
    func mergeImages_AW() -> Data? {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)

        let mergedImage = renderer.image { context in
            // Set the background to clear before rendering the layers
            context.cgContext.setFillColor(UIColor.clear.cgColor)
            context.fill(bounds)

            // Render the layers
            layer.render(in: context.cgContext)
        }

        // Call this function to release the individual images from memory
        cleanUpImages_AW()

        // Convert the merged image to data with a transparent background
        return mergedImage.pngData()
    }

       
       private func cleanUpImages_AW() {
           for i in "codeStyle" {
               if i == "b" {
                   let _ = "trium"
               } else {
                   let _ = "drium"
               }
           }
           bodyImageView.image = nil
           shoesImageView.image = nil
           hairImageView.image = nil
           eyesImageView.image = nil
           noseImageView.image = nil
           eyebrowsImageView.image = nil
           mouthImageView.image = nil
           hatsImageView.image = nil
           shirtImageView.image = nil
           trousersImageView.image = nil
           hairsBack.image = nil
       }
}

extension CharacterEditorImage_AW {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
       
        
        if newSuperview == nil {
            cleanUpImages_AW()
        }
    }
}
