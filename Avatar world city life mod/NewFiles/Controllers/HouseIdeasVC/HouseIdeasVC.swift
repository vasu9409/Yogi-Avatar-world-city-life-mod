//
//  HouseIdeasVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//

import UIKit

let localFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path + "/content"

class HouseIdeasVC: UIViewController, SearchVCDelegate {
    func selectedFromSearch(mods: E8V?, houseMods: The8Ua8Onb?) {
        if houseMods != nil {
            let ctrl = ModsDetailsVC()
            ctrl.largeTitle = "House ideas"
            ctrl.detailsMode = houseMods
            ctrl.isFromHouseMods = true
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var menuButtonView: UIView!
    @IBOutlet weak var modsTitleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var catCollectionView: UICollectionView!
    
    var isForMods: Bool = false
    var scrollPositions: [String: CGPoint] = [:]
    var categoryNameArray: [String] = ["All", "New", "Favourites", "Top"]
    var selectedcategoryName: String = "All"
    
    var houseIdeaDataModel: [The8Ua8Onb] = []
//    var favouritesArray: [The8Ua8Onb] = []
    var filterArray: [The8Ua8Onb] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.fetchModsData()
        self.setupCollectionView()
        
        self.menuButtonView.clipsToBounds = true
        self.searchButtonView.clipsToBounds = true
        self.searchButtonView.layer.cornerRadius = IS_IPAD ? 41 : 24
        self.menuButtonView.layer.cornerRadius = IS_IPAD ? 41 : 24
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    @IBAction func menuButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let ctrl = SearchVC()
        ctrl.modalPresentationStyle = .overFullScreen
        ctrl.isFromHouseMods = true
        ctrl.houseModsFilterArray = self.filterArray
        ctrl.delegate = self
        self.present(ctrl, animated: false)
    }
    
    func fetchModsData() {
        let jsonFilePath = localFolderPath + "/" + ContentType_AW.houseIdeas.rawValue + "/" + "content.json"
        
        if let files: HouseIdeas = FileSession_AW.shared.getModelFromFile_AW(from: URL(fileURLWithPath: jsonFilePath)) {
            self.houseIdeaDataModel.removeAll()
            for (_, value) in files.um3Jdnw.the8Ua8Onb {
                
                self.houseIdeaDataModel.append(value)
                
            }
            
            self.filterArray = self.houseIdeaDataModel
        }
    }
    
    private func setupUI() {
        self.modsTitleLabel.font = GilroyAppConstFontsTexture.gilroyDimension(size: IS_IPAD ? 36 : 22, style: .bold)
    }
    
    private func setupCollectionView() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(for: "HouseIdeasCell")
        
        self.catCollectionView.dataSource = self
        self.catCollectionView.delegate = self
        self.catCollectionView.registerNib(for: "CategoryCell")
        
    }
    
    func loadFavouritesFromUserDefaults() {
        
    }
}


extension HouseIdeasVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.catCollectionView {
            return self.categoryNameArray.count
        }
        return self.filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.catCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            
            cell.catNameLabel.text = self.categoryNameArray[indexPath.row]
            
            cell.selected(self.selectedcategoryName == self.categoryNameArray[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseIdeasCell", for: indexPath) as? HouseIdeasCell else { return UICollectionViewCell() }
            
            cell.ideaTitleName.text = self.filterArray[indexPath.row].title
            
            if (UserDefaults.MVTMindFreshnerQuestionsSave.contains(where: { $0.the1477 == self.filterArray[indexPath.row].the1477 })) {
                cell.heartButton.setImage(UIImage(named: "newStromheartStone"), for: .normal)
            } else {
                cell.heartButton.setImage(UIImage(named: "heartuncheckbroken"), for: .normal)
            }
            
            
            let imagePath = localFolderPath + "/" + ContentType_AW.houseIdeas.rawValue + "/" + self.filterArray[indexPath.row].the1477
            cell.cellImageVIew.image = UIImage(data: self.loadImageFromFile(at: imagePath))
            
            cell.isheartButtonTapped = { [weak self] in
                guard let self else { return }
                
                if !(UserDefaults.MVTMindFreshnerQuestionsSave.contains(where: { $0.the1477 == self.filterArray[indexPath.row].the1477 })) {
                    
                    UserDefaults.MVTMindFreshnerQuestionsSave.append(self.filterArray[indexPath.row])
                    UserDefaults.standard.synchronize()
                } else {
                    UserDefaults.MVTMindFreshnerQuestionsSave.removeAll(where: { ($0.the1477 == self.filterArray[indexPath.row].the1477) })
                    UserDefaults.standard.synchronize()
                }
                
                self.collectionView.reloadData()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.catCollectionView {
            
            scrollPositions[selectedcategoryName] = collectionView.contentOffset
            
            self.selectedcategoryName = self.categoryNameArray[indexPath.row]
            self.catCollectionView.reloadData()
            
            switch self.categoryNameArray[indexPath.row] {
            case "All" :
                self.filterArray = self.houseIdeaDataModel
                break
            case "New" :
                self.filterArray = self.houseIdeaDataModel.filter { $0.isNew }
                break
            case "Favourites" :
                self.filterArray = UserDefaults.MVTMindFreshnerQuestionsSave
                break
            case "Top" :
                self.filterArray = self.houseIdeaDataModel.filter { $0.isTop }
                break
            default : break
            }
            
            self.collectionView.reloadData()
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let targetOffset = self.scrollPositions[self.selectedcategoryName] ?? .zero
                self.catCollectionView.setContentOffset(targetOffset, animated: false)
            }
            
        } else {
            let ctrl = ModsDetailsVC()
            ctrl.largeTitle = "House ideas"
            ctrl.detailsMode = self.filterArray[indexPath.row]
            ctrl.isFromHouseMods = true
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.catCollectionView {
            let labelWidth = calculateCellWidth(text: self.categoryNameArray[indexPath.row], collectionView: collectionView)
            // Return the maximum of the cell's width and the label's required width
            return CGSize(width: labelWidth, height: collectionView.frame.height)
        } else {
            return CGSize(width: (collectionView.frame.width - (IS_IPAD ? 16 : 8)) / 2, height: IS_IPAD ? 300 : 216)
        }
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
