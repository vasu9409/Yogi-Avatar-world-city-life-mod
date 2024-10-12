//
//  HouseIdeasVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//

import UIKit

class HouseIdeasVC: UIViewController {

    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var menuButtonView: UIView!
    @IBOutlet weak var modsTitleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var catCollectionView: UICollectionView!
    
    
    var isForMods: Bool = false
    
    var categoryNameArray: [String] = ["All", "New", "Favourites", "New"]
    var selectedcategoryName: String = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupTableViewAndCollectionView()
        
        self.menuButtonView.clipsToBounds = true
        self.searchButtonView.clipsToBounds = true
        self.searchButtonView.layer.cornerRadius = IS_IPAD ? 41 : 24
        self.menuButtonView.layer.cornerRadius = IS_IPAD ? 41 : 24
        
    }
    
    @IBAction func menuButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
    private func setupUI() {
        self.modsTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
    }
    
    private func setupTableViewAndCollectionView() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(for: "HouseIdeasCell")
        
        self.catCollectionView.dataSource = self
        self.catCollectionView.delegate = self
        self.catCollectionView.registerNib(for: "CategoryCell")
        
    }
}


extension HouseIdeasVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.catCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            
            cell.catNameLabel.text = self.categoryNameArray[indexPath.row]
            
            cell.selected(self.selectedcategoryName == self.categoryNameArray[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseIdeasCell", for: indexPath) as? HouseIdeasCell else { return UICollectionViewCell() }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.catCollectionView {
            self.selectedcategoryName = self.categoryNameArray[indexPath.row]
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.catCollectionView {
            let labelWidth = self.calculateCellWidth(text: self.categoryNameArray[indexPath.row], collectionView: collectionView)
            // Return the maximum of the cell's width and the label's required width
            return CGSize(width: labelWidth, height: collectionView.frame.height)
        } else {
            return CGSize(width: (collectionView.frame.width - (IS_IPAD ? 16 : 8)) / 2, height: IS_IPAD ? 368 : 216)
        }
    }
    
    private func calculateCellWidth(text: String, collectionView: UICollectionView) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 30 : 20, style: .bold)
        label.sizeToFit()
        let cellWidth = label.frame.width + 50
        return cellWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.catCollectionView {
            return UIEdgeInsets(top: 0, left: (IS_IPAD ? 100 : 20), bottom: 0, right: (IS_IPAD ? 100 : 20))
        }
        return UIEdgeInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return IS_IPAD ? 16 : 8
    }
}
