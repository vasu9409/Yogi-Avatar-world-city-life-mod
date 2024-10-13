//
//  SkinMakerPreviewVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 13/10/24.
//

import UIKit

class SkinMakerPreviewVC: UIViewController {

    @IBOutlet weak var themeCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryName = ["Name"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.registerNib(for: "CategoryCell")
        
        self.themeCollectionView.delegate = self
        self.themeCollectionView.dataSource = self
        self.themeCollectionView.registerNib(for: "SkinCell")
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
    }
}


extension SkinMakerPreviewVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.themeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
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
        let labelWidth = self.calculateCellWidth(text: self.categoryName[indexPath.row], collectionView: collectionView)
        // Return the maximum of the cell's width and the label's required width
        return CGSize(width: labelWidth, height: collectionView.frame.height)
    }
    
    private func calculateCellWidth(text: String, collectionView: UICollectionView) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 30 : 20, style: .bold)
        label.sizeToFit()
        let cellWidth = label.frame.width + 50
        return cellWidth
    }
}
