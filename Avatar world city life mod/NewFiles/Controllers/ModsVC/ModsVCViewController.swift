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
        
    var categoryNameArray: [String] = ["All", "New", "Favourites", "New"]
    var selectedcategoryName: String = "All"
    
    var modsDataModel: [E8V] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchModsData()
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
        let ctrl = SearchVC()
        ctrl.modalPresentationStyle = .overFullScreen
        self.present(ctrl, animated: false)
    }
    
    func fetchModsData() {
        let jsonFilePath = filesPath.first { $0.lastPathComponent == ContentType_AW.mod.rawValue }
        
        if let files: Mods = FileSession_AW.shared.getModelFromFile_AW(from: jsonFilePath!) {
            self.modsDataModel.removeAll()
            for (_, value) in files.the7Rqpw.e8V {
                
                self.modsDataModel.append(value)
                
            }
        }
    }
    
    private func setupUI() {
        self.modsTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
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
        return self.modsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModsTableCell", for: indexPath) as? ModsTableCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.nameLabel.text = self.modsDataModel[indexPath.row].title
        
        cell.isArrowButtonTapped = { [weak self] in
            guard let self else { return }
            let ctrl = ModsDetailsVC()
            ctrl.largeTitle = "Mods"
            ctrl.modsDetailsMode = self.modsDataModel[indexPath.row]
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        
        cell.isheartButtonTapped = { [weak self] in
            guard let self else { return }
            let ctrl = ModsDetailsVC()
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        
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
        
        let labelWidth = calculateCellWidth(text: self.categoryNameArray[indexPath.row], collectionView: collectionView)
        // Return the maximum of the cell's width and the label's required width
        return CGSize(width: labelWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (IS_IPAD ? 100 : 20), bottom: 0, right: (IS_IPAD ? 100 : 20))
    }
}
