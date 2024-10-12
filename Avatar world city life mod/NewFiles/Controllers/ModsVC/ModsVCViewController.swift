//
//  ModsVCViewController.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import UIKit

class ModsVCViewController: UIViewController {
    
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var menuButtonView: UIView!
    @IBOutlet weak var modsTitleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
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
        self.modsTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 42 : 24, style: .bold)
    }
    
    private func setupTableViewAndCollectionView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(for: "ModsTableCell")
        self.tableView.separatorStyle = .none
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(for: "CategoryCell")
        
    }

}

extension ModsVCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModsTableCell", for: indexPath) as? ModsTableCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IS_IPAD ? 368 : 216
    }
}

extension ModsVCViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        cell.catNameLabel.text = self.categoryNameArray[indexPath.row]
        
        cell.selected(self.selectedcategoryName == self.categoryNameArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedcategoryName = self.categoryNameArray[indexPath.row]
        self.collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel()
        label.text = self.categoryNameArray[indexPath.row]
        label.textAlignment = .center
        label.sizeToFit()
        label.layoutIfNeeded()
        
        let labelWidth = label.frame.width + 70
        
        // Return the maximum of the cell's width and the label's required width
        return CGSize(width: labelWidth, height: collectionView.frame.height)
    }
}
