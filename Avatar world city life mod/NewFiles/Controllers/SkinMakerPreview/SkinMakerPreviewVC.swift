//
//  SkinMakerPreviewVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 13/10/24.
//

import UIKit
import Photos
import RealmSwift

struct CustomEditorStroke {
    let type: String
    let data: Accessory
}

class SkinMakerPreviewVC: UIViewController {

    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var themeCollectionView: UICollectionView!
    @IBOutlet weak var editingPictureView: CharacterEditorImage_AW!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryName = ["Shoes", "Eyes", "Body", "Mouth", "Clothes", "Hair", "Brows", "Headdress", "Face", "Accessory"]
    var selectedcategoryName: String = "Shoes"
    
    var modsDataModel: [CustomEditorStroke] = []
    var filterArray: [CustomEditorStroke] = []
    
    var selectedDictionaryData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchModsData()
        
        self.largeTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
        
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.registerNib(for: "CategoryCell")
        
        self.themeCollectionView.delegate = self
        self.themeCollectionView.dataSource = self
        self.themeCollectionView.registerNib(for: "SkinCell")
        
        self.assignFirstTime()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        guard let image = self.editingPictureView.toImage() else { return }
        
        let ctrl = ShowSkinApplied()
        ctrl.selectedImage = image
        self.navigationController?.pushViewController(ctrl, animated: true)
    }

    func fetchModsData() {
        let jsonFilePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + "content.json"
        
        if let files: EditorContent = FileSession_AW.shared.getModelFromFile_AW(from: URL(fileURLWithPath: jsonFilePath)) {
            self.modsDataModel.removeAll()
            
            // Add strokes for each category
            appendStrokes(for: "Shoes", from: files.z3D.shoes)
            appendStrokes(for: "Eyes", from: files.z3D.eyes)
            appendStrokes(for: "Body", from: files.z3D.body)
            appendStrokes(for: "Mouth", from: files.z3D.mouth)
            appendStrokes(for: "Clothes", from: files.z3D.clothes)
            appendStrokes(for: "Hair", from: files.z3D.hair)
            appendStrokes(for: "Brows", from: files.z3D.brows)
            appendStrokes(for: "Headdress", from: files.z3D.headdress)
            appendStrokes(for: "Face", from: files.z3D.face)
            appendStrokes(for: "Accessory", from: files.z3D.accessory)
        }
    }
    
    private func appendStrokes(for type: String, from data: [String: Accessory]) {
        for (_, value) in data {
            let stroke = CustomEditorStroke(type: type, data: value)
            self.modsDataModel.append(stroke)
        }
    }
}

extension SkinMakerPreviewVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.categoryCollectionView ? self.categoryName.count : self.filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            cell.catNameLabel.text = self.categoryName[indexPath.row]
            cell.selected(self.selectedcategoryName == self.categoryName[indexPath.row])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkinCell", for: indexPath) as? SkinCell else { return UICollectionViewCell() }
            
            let data = self.filterArray[indexPath.row]
            let imagePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + data.data.previewImage
            cell.previewImageView.image = UIImage(data: self.loadImageFromFile(at: imagePath))
            
            cell.skinImageBGView.backgroundColor = (self.selectedcategoryName == self.filterArray[indexPath.row].type &&
                                                     self.selectedDictionaryData[self.selectedcategoryName] as? Int == indexPath.row) ?
                UIColor(named: "newblackcolorfounded") : UIColor(named: "lightercoloruidrag")
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == self.themeCollectionView ?
            CGSize(width: collectionView.frame.height, height: collectionView.frame.height) :
            CGSize(width: calculateCellWidth(text: self.categoryName[indexPath.row], collectionView: collectionView), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoryCollectionView {
            self.selectedcategoryName = self.categoryName[indexPath.row]
            self.filterArray = self.modsDataModel.filter { $0.type == self.selectedcategoryName }
            self.categoryCollectionView.reloadData()
            self.themeCollectionView.reloadData()
        } else {
            let data = self.filterArray[indexPath.row]
            let imagePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + data.data.imageOriginal
            let editorContentImgData = self.loadImageFromFile(at: imagePath)
            
            self.selectedDictionaryData[self.selectedcategoryName] = indexPath.row
            updateEditorImage(for: self.selectedcategoryName, with: editorContentImgData)
            
            self.themeCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (IS_IPAD ? 100 : 16), bottom: 0, right: (IS_IPAD ? 100 : 16))
    }
    
    private func updateEditorImage(for category: String, with imageData: Data) {
        switch category {
        case "Shoes":
            self.editingPictureView.shoesImageView.image = UIImage(data: imageData)
        case "Eyes":
            self.editingPictureView.eyesImageView.image = UIImage(data: imageData)
        case "Body":
            self.editingPictureView.bodyImageView.image = UIImage(data: imageData)
        case "Mouth":
            self.editingPictureView.mouthImageView.image = UIImage(data: imageData)
        case "Clothes":
            self.editingPictureView.shirtImageView.image = UIImage(data: imageData)
        case "Hair":
            self.editingPictureView.hairImageView.image = UIImage(data: imageData)
        case "Brows":
            self.editingPictureView.eyebrowsImageView.image = UIImage(data: imageData)
        case "Headdress":
            self.editingPictureView.hairsBack.image = UIImage(data: imageData)
        case "Face":
            self.editingPictureView.noseImageView.image = UIImage(data: imageData)
        case "Accessory":
            self.editingPictureView.hatsImageView.image = UIImage(data: imageData)
        default:
            break
        }
    }
    
    func assignFirstTime() {
        // Assign default images for the first time for all categories and set the first index (0) as selected
        assignEditorImage(for: "Shoes")
        assignEditorImage(for: "Eyes")
        assignEditorImage(for: "Body")
        assignEditorImage(for: "Mouth")
        assignEditorImage(for: "Clothes")
        assignEditorImage(for: "Hair")
        assignEditorImage(for: "Brows")
    }

    private func assignEditorImage(for category: String) {
        // Filter the mods data model based on the category
        let filteredData = self.modsDataModel.filter({ $0.type == category })
        
        // Check if there is any data for the category
        if let firstData = filteredData.first {
            // Set the image for the first item
            let imagePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + firstData.data.imageOriginal
            let imageData = self.loadImageFromFile(at: imagePath)
            
            // Update the editor with the image
            updateEditorImage(for: category, with: imageData)
            
            // Set the selected index as 0 for the first time for this category
            selectedDictionaryData[category] = 0
            
            // Reload the theme collection view if needed to reflect selection
            self.themeCollectionView.reloadData()
        }
    }

}


extension UIView {
    // Function to create an image from a UIView
    func toImage() -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
//        defer {
//            UIGraphicsEndImageContext()
//        }
//        if let context = UIGraphicsGetCurrentContext() {
//            self.layer.render(in: context)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            return image
//        }
//        return nil
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false // This ensures the image will support transparency
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)
        return renderer.image { ctx in
            // Make sure the context's background is clear before rendering the view
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            ctx.cgContext.fill(self.bounds)
            
            // Render the view's layer
            self.layer.render(in: ctx.cgContext)
        }
    }
}




//    guard let image = self.editingPictureView.toImage() else { return }
//
//        // Save the PNG data to the photo library using the Photos framework
//        PHPhotoLibrary.shared().performChanges({
//            // Request to add the PNG image to the photo library
//            let request = PHAssetCreationRequest.forAsset()
//            request.addResource(with: .photo, data: pngData, options: nil)
//        }) { success, error in
//            if success {
//                print("Image saved successfully with transparency.")
//            } else {
//                print("Error saving image: \(error?.localizedDescription ?? "Unknown error")")
//            }
//        }
    
    
