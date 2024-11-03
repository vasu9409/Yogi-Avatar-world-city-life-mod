//
//  ModsVCViewController.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import UIKit

class ModsVCViewController: UIViewController, SearchVCDelegate {
    func selectedFromSearch(mods: E8V?, houseMods: The8Ua8Onb?) {
        if mods != nil {
            let ctrl = ModsDetailsVC()
            ctrl.largeTitle = "Mods"
            ctrl.modsDetailsMode = mods
            ctrl.isFromHouseMods = false
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var menuButtonView: UIView!
    @IBOutlet weak var modsTitleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
        
    var categoryNameArray: [String] = ["All", "New", "Favourites", "Popular"]
    var selectedcategoryName: String = "All"
    
    var modsDataModel: [E8V] = []
//    var favouritesArray: [E8V] = []
    var filterArray: [E8V] = []
    
    var scrollPositions: [String: CGPoint] = [:]
    
    let localFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path + "/content"
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    @IBAction func menuButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let ctrl = SearchVC()
        ctrl.modalPresentationStyle = .overFullScreen
        ctrl.isFromHouseMods = false
        ctrl.modsFilterArray = self.filterArray
        ctrl.delegate = self
        self.present(ctrl, animated: false)
    }
    
    func fetchModsData() {
        let jsonFilePath = localFolderPath + "/" + ContentType_AW.mod.rawValue + "/" + "content.json"
        
        if let files: Mods = FileSession_AW.shared.getModelFromFile_AW(from: URL(fileURLWithPath: jsonFilePath)) {
            self.modsDataModel.removeAll()
            for (_, value) in files.the7Rqpw.e8V {
                
                self.modsDataModel.append(value)
                
            }
            
            self.filterArray = self.modsDataModel
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
        return self.filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModsTableCell", for: indexPath) as? ModsTableCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.nameLabel.text = self.filterArray[indexPath.row].title
        
        let imagePath = self.localFolderPath + "/" + ContentType_AW.mod.rawValue + "/" + self.modsDataModel[indexPath.row].the00Ika
        cell.cellImageView.image = UIImage(data: self.loadImageFromFile(at: imagePath))
        
        if UserDefaults.AvatarModsFavData.contains(where: { $0.the00Ika == self.filterArray[indexPath.row].the00Ika}) {
            cell.heartButton.setImage(UIImage(named: "newStromheartStone"), for: .normal)
        } else {
            cell.heartButton.setImage(UIImage(named: "heartuncheckbroken"), for: .normal)
        }
        
        cell.isArrowButtonTapped = { [weak self] in
            guard let self else { return }
            let ctrl = ModsDetailsVC()
            ctrl.largeTitle = "Mods"
            ctrl.modsDetailsMode = self.filterArray[indexPath.row]
            ctrl.isFromHouseMods = false
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        
        cell.isheartButtonTapped = { [weak self] in
            guard let self else { return }
            
            if !(UserDefaults.AvatarModsFavData.contains(where: { $0.the00Ika == self.filterArray[indexPath.row].the00Ika })) {
                
                UserDefaults.AvatarModsFavData.append(self.filterArray[indexPath.row])
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.AvatarModsFavData.removeAll(where: { ($0.the00Ika == self.filterArray[indexPath.row].the00Ika) })
                UserDefaults.standard.synchronize()
            }
            
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IS_IPAD ? 408 : 246
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        scrollPositions[selectedcategoryName] = tableView.contentOffset
//        
//        self.selectedcategoryName = self.categoryNameArray[indexPath.row]
//        self.collectionView.reloadData()
//        
//        switch self.categoryNameArray[indexPath.row] {
//        case "All" :
//            self.filterArray = self.modsDataModel
//            break
//        case "New" :
//            self.filterArray = self.modsDataModel.filter { $0.isNew }
//            break
//        case "Favourites" :
//            self.filterArray = self.favouritesArray
//            break
//        case "Popular" :
//            self.filterArray = self.modsDataModel.filter { $0.isPopular }
//            break
//        default : break
//        }
//        
//        self.tableView.reloadData()
//        
//        if let savedPosition = scrollPositions[selectedcategoryName] {
//            tableView.setContentOffset(savedPosition, animated: false)
//        } else {
//            tableView.setContentOffset(.zero, animated: false)
//        }
//        
//        self.tableView.reloadData()
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Save current scroll position before switching categories
        scrollPositions[selectedcategoryName] = tableView.contentOffset
        
        // Update selected category and filter array accordingly
        selectedcategoryName = categoryNameArray[indexPath.row]
        self.collectionView.reloadData()
        filterArray = modsDataModel.filter { mod in
            switch selectedcategoryName {
            case "New": return mod.isNew
            case "Favourites": return UserDefaults.AvatarModsFavData.contains { $0.the00Ika == mod.the00Ika }
            case "Popular": return mod.isPopular
            default: return true // "All" category
            }
        }
        
        // Reload data and set the scroll position after reload completes
        tableView.reloadData()
        
        // Delay setting the scroll position to allow reload to complete
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let targetOffset = self.scrollPositions[self.selectedcategoryName] ?? .zero
            self.tableView.setContentOffset(targetOffset, animated: false)
        }
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
