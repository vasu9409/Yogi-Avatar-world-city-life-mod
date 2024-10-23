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
    
    var selectedStyle: Int = 0
    
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
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        guard let image = editingPictureView.toImage() else { return }
        
        // Convert UIImage to PNG data
        guard let pngData = image.pngData() else { return }
        
        do {
            
            let realm = try Realm()
            
            // Create a new Person object
            let newPerson = ListElementObject()
            newPerson.data = pngData
            // Save the new person object to Realm
            try realm.write {
                realm.add(newPerson)
            }
            
        } catch {
            
        }
        
        // Save the PNG data to the photo library using the Photos framework
        PHPhotoLibrary.shared().performChanges({
            // Request to add the PNG image to the photo library
            let request = PHAssetCreationRequest.forAsset()
            request.addResource(with: .photo, data: pngData, options: nil)
        }) { success, error in
            if success {
                print("Image saved successfully with transparency.")
            } else {
                print("Error saving image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
  
    func fetchModsData() {
        let jsonFilePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + "content.json"
        
        if let files: EditorContent = FileSession_AW.shared.getModelFromFile_AW(from: URL(fileURLWithPath: jsonFilePath)) {
            self.modsDataModel.removeAll()
            
            for (_, value) in files.z3D.shoes {
                let stroke = CustomEditorStroke(type: "Shoes", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.eyes {
                let stroke = CustomEditorStroke(type: "Eyes", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.body {
                let stroke = CustomEditorStroke(type: "Body", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.mouth {
                let stroke = CustomEditorStroke(type: "Mouth", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.clothes {
                let stroke = CustomEditorStroke(type: "Clothes", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.hair {
                let stroke = CustomEditorStroke(type: "Hair", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.brows {
                let stroke = CustomEditorStroke(type: "Brows", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.headdress {
                let stroke = CustomEditorStroke(type: "Headdress", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.face {
                let stroke = CustomEditorStroke(type: "Face", data: value)
                self.modsDataModel.append(stroke)
            }
            
            for (_, value) in files.z3D.accessory {
                let stroke = CustomEditorStroke(type: "Accessory", data: value)
                self.modsDataModel.append(stroke)
            }
        }
    }
}


extension SkinMakerPreviewVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryCollectionView {
            return self.categoryName.count
        } else {
            return self.filterArray.count // + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView != self.themeCollectionView {
            
            // Category CollectionView
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            
            cell.catNameLabel.text = self.categoryName[indexPath.row]
            
            cell.selected(self.selectedcategoryName == self.categoryName[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkinCell", for: indexPath) as? SkinCell else { return UICollectionViewCell() }
            
//            if indexPath.row == 0 {
//                if selectedStyle == 0 {
//                    cell.previewImageView.image = UIImage(named: "tagNoneSelectedSuffle")?.withTintColor(UIColor(named: "whitedowncolorset")!, renderingMode: .alwaysTemplate)
//                    cell.skinImageBGView.backgroundColor = UIColor(named: "newblackcolorfounded")
//                } else {
//                    cell.previewImageView.image = UIImage(named: "tagNoneSelectedSuffle")?.withTintColor(UIColor(named: "newblackcolorfounded")!, renderingMode: .alwaysTemplate)
//                    cell.skinImageBGView.backgroundColor = UIColor(named: "lightercoloruidrag")
//                }
//            } else {
                let data = self.filterArray[indexPath.row] // - 1]
                let imagePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + data.data.previewImage
                cell.previewImageView.image = UIImage(data: self.loadImageFromFile(at: imagePath))
                
                cell.skinImageBGView.backgroundColor = (selectedStyle == indexPath.row) ? UIColor(named: "newblackcolorfounded") : UIColor(named: "lightercoloruidrag")
//            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.themeCollectionView {
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        }
        
        
        // Category CollectionView
        let labelWidth = calculateCellWidth(text: self.categoryName[indexPath.row], collectionView: collectionView)
        return CGSize(width: labelWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != self.themeCollectionView {
            // Category CollectionView
            
            self.selectedcategoryName = self.categoryName[indexPath.row]
            self.categoryCollectionView.reloadData()
            
            switch self.categoryName[indexPath.row] {
            case "Shoes" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Shoes" }
                break
            case "Eyes" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Eyes" }
                break
            case "Body" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Body" }
                break
            case "Mouth" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Mouth" }
                break
            case "Clothes" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Clothes" }
                break
            case "Hair" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Hair" }
                break
            case "Brows" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Brows" }
                break
            case "Headdress" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Headdress" }
                break
            case "Face" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Face" }
                break
            case "Accessory" :
                self.filterArray = self.modsDataModel.filter { $0.type == "Accessory" }
                break
            
            default : break
                
            }
            
            self.themeCollectionView.reloadData()
        } else {
            self.selectedStyle = indexPath.row
            
            
            let imagePath = localFolderPath + "/" + ContentType_AW.unknown.rawValue + "/" + self.filterArray[indexPath.row].data.imageOriginal // - 1].data.previewImage
            let editorContentImgData = self.loadImageFromFile(at: imagePath)
            
            switch self.selectedcategoryName {
            case "Shoes" :
                self.selectedDictionaryData["Shoes"] = [indexPath.row]
                self.editingPictureView.shoesImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Eyes" :
                self.selectedDictionaryData["Eyes"] = [indexPath.row]
                self.editingPictureView.eyesImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Body" :
                self.selectedDictionaryData["Body"] = [indexPath.row]
                self.editingPictureView.bodyImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Mouth" :
                self.selectedDictionaryData["Mouth"] = [indexPath.row]
                self.editingPictureView.mouthImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Clothes" :
                self.selectedDictionaryData["Clothes"] = [indexPath.row]
                self.editingPictureView.shirtImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Hair" :
                self.selectedDictionaryData["Hair"] = [indexPath.row]
                self.editingPictureView.hairImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Brows" :
                self.selectedDictionaryData["Brows"] = [indexPath.row]
                self.editingPictureView.eyebrowsImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Headdress" :
                self.selectedDictionaryData["Headdress"] = [indexPath.row]
                self.editingPictureView.hairsBack.image = UIImage(data: editorContentImgData)
                break
                
            case "Face" :
                self.selectedDictionaryData["Face"] = [indexPath.row]
                self.editingPictureView.noseImageView.image = UIImage(data: editorContentImgData )
                break
                
            case "Accessory" :
                self.selectedDictionaryData["Accessory"] = [indexPath.row]
                self.editingPictureView.hatsImageView.image = UIImage(data: editorContentImgData )
                break
            
            default : break
                
//                self.editingPictureView.trousersImageView.getPdfImage_AW(with: editorContentImgData )
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (IS_IPAD ? 100 : 16), bottom: 0, right: (IS_IPAD ? 100 : 16))
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
