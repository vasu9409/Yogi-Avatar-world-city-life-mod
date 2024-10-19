//
//  SkinMakerPreviewVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 13/10/24.
//

import UIKit

struct CustomEditorStroke {
    let type: String
    let data: Accessory
}

class SkinMakerPreviewVC: UIViewController {

    @IBOutlet weak var themeCollectionView: UICollectionView!
    @IBOutlet weak var editingPictureView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryName = ["Shoes", "Eyes", "Body", "Mouth", "Clothes", "Hair", "Brows", "Headdress", "Face", "Accessory"]
    var selectedcategoryName: String = "Shoes"
    
    var modsDataModel: [CustomEditorStroke] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchModsData()
        
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
    
    func fetchModsData() {
        let jsonFilePath = filesPath.first { $0.lastPathComponent == ContentType_AW.unknown.rawValue }
        
        if let files: EditorContent = FileSession_AW.shared.getModelFromFile_AW(from: jsonFilePath!) {
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
        return self.categoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView != self.themeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            
            cell.catNameLabel.text = self.categoryName[indexPath.row]
            
            cell.selected(self.selectedcategoryName == self.categoryName[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkinCell", for: indexPath) as? SkinCell else { return UICollectionViewCell() }
            
            
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.themeCollectionView {
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        }
        let labelWidth = calculateCellWidth(text: self.categoryName[indexPath.row], collectionView: collectionView)
        // Return the maximum of the cell's width and the label's required width
        return CGSize(width: labelWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != self.themeCollectionView {
            self.selectedcategoryName = self.categoryName[indexPath.row]
            self.categoryCollectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (IS_IPAD ? 100 : 16), bottom: 0, right: (IS_IPAD ? 100 : 16))
    }
}
