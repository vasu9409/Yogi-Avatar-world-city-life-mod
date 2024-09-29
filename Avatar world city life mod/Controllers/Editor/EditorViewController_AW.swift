//
//  EditorViewController_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

class EditorViewController_AW: BaseController_AW {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    private var loadingView = LoadingView_AW()
    
    private var storeManagerContent: StoreManagerCharacters_AW { .shared }
    private var dropBox: DBManager_AW { DBManager_AW.shared }
    private var content: [CharacterPriviewModelObject_AW] = []
    private var isScrollEnabled: Bool = false
    private var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    private var currentPage: Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection_AW()
        
        ReachabilityManager_AW.shared.isActiveInternet = { [weak self] in
            self?.loadingView.removeFromSuperview()
            self?.fetchContent_AW()
        }
    }
    
    private func setupCollection_AW() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register_AW([EditorCollectionViewCell_AW.identifier])
        collectionView.isScrollEnabled = isScrollEnabled
        let layout = CarouselFlowLayout_AW()
        let padding: CGFloat = 10.0
        var itemWidth: CGFloat = 0.0
        var itemHeight: CGFloat = 0.0
        let screenWidth = UIScreen.main.bounds.width

        
        if UIDevice.current.userInterfaceIdiom == .pad {
            itemWidth = (screenWidth - padding)
            itemHeight = (screenWidth - padding) / 2
            layout.spacingMode = .overlap(visibleOffset: 240)
            layout.sideItemScale = 0.4
        } else {
            itemWidth = (screenWidth - padding) / 1.2
            itemHeight = (screenWidth - padding) / 0.40
            layout.spacingMode = .overlap(visibleOffset: 165)
            layout.sideItemScale = 0.7
        }
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        setupEditorBackground_AW()
        fetchContent_AW()
        updateUI_AW(with: currentPage)
        setupCollection_AW()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !isContentUploaded_AW() {
            self.loadingView.removeFromSuperview()
        }
    }
    
    func isContentUploaded_MFour() -> Bool {
        let array = dropBox.contentManager.fetchEditorContent_AW().filter({$0.imgData != nil })
        return array.count == FileSession_AW.shared.getEditorDropBoxContent_AW().count
    }
    
    private func fetchContent_AW() {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if isContentUploaded_MFour() {
            getContent_AW()
            dispatchGroup.leave()
        } else {
            showLoading_AW()
            storeManagerContent.removeAllCharacterPreviewModels_AW()
            DBManager_AW.shared.fetchEditorContent_AW {
                dispatchGroup.leave()
                print("🔴 fetching content")
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.getContent_AW()
            self.loadingView.removeFromSuperview()
        }
    }
    
    private func isContentUploaded_AW() -> Bool {
        let array = dropBox.contentManager.fetchEditorContent_AW().filter({$0.imgData != nil })
        return array.count == FileSession_AW.shared.getEditorDropBoxContent_AW().count
    }
    
    private func getContent_AW() {
        updateContent_AW()
        updateDeleteButtonState()
        reloadCollectionView()
        scrollToSelectedIndexPath()
        scrollToLastItemIfNeeded()
    }

    private func updateContent_AW() {
        content = storeManagerContent.getCharacterPreviewModels_AW()
    }

    private func updateDeleteButtonState() {
        deleteBtn.isEnabled = !storeManagerContent.getCharacterPreviewModels_AW().isEmpty
    }

    private func reloadCollectionView() {
        collectionView.reloadData()
    }

    private func scrollToSelectedIndexPath() {
        guard !content.isEmpty else { return }
        
        if selectedIndexPath.row < content.count {
            let targetIndexPath = storeManagerContent.isNewElementAdded ? IndexPath(item: currentPage, section: 0) : selectedIndexPath
            collectionView.scrollToItem(at: targetIndexPath, at: .centeredHorizontally, animated: true)
            selectedIndexPath = targetIndexPath
            updateUI_AW(with: targetIndexPath.row)
        } else {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }

    private func scrollToLastItemIfNeeded() {
        if storeManagerContent.isNewElementAdded {
            scrollToLastItem()
        }
    }

    private func scrollToLastItem() {
        collectionView.scrollToItem(at: IndexPath(row: content.count - 1, section: 0), at: .centeredHorizontally, animated: true)
        selectedIndexPath = IndexPath(row: content.count - 1, section: 0)
        updateUI_AW(with: content.count - 1)
    }

    
    private func showLoading_AW() {
        loadingView = LoadingView_AW(frame: view.frame)
        self.view.addSubview(loadingView)
    }
    
    private func updateUI_AW(with currentPage: Int) {
        self.currentPage = currentPage
        leftButton.isHidden = currentPage == 0
        rightButton.isHidden = currentPage == content.count - 1
        
        if currentPage == self.content.count - 1 { //last page
            self.rightButton.isHidden = true
        } else if self.content.count == 2 && currentPage == 0 {
            self.rightButton.isHidden = false
            self.leftButton.isHidden = true
        } else if self.content.count == 2 && currentPage == 1 {
            self.rightButton.isHidden = true
            self.leftButton.isHidden = false
        } else {
            self.rightButton.isHidden = false
        }
            
            if self.content.count == 1 || self.content.isEmpty {
                self.rightButton.isHidden = true
                self.leftButton.isHidden = true
            }
    }
    
    
    @IBAction func leftButtonAction(_ sender: Any) {
        let prevIndex = max(currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        currentPage = prevIndex
        collectionView?.isPagingEnabled = false
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        selectedIndexPath = indexPath
        updateUI_AW(with: currentPage)
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        let nextIndex = min(currentPage + 1, content.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        currentPage = nextIndex
        collectionView?.isPagingEnabled = false
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        selectedIndexPath = indexPath
        updateUI_AW(with: currentPage)
    }
    
    
    @IBAction func addButtonAction(_ sender: Any) {
        let vc = EditorSetupViewController_AW()
        vc.modalPresentationStyle = .fullScreen
        vc.typeCharacterEditor = .new
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        AlertManager_AW.showEditorAlert_AW(with: "Attention", msg: "Character deletion is irreversible. Continue?", leadingTitle: "Delete", trailingTitle: "No", doneActionHandler: { [weak self] in
            if let currentIndexPath = self?.currentPage, !(self?.content.isEmpty ?? false)  {
                guard let model = self?.content[currentIndexPath] else { return }
                
                let uuid = model.uuid
                self?.storeManagerContent.deleteCharacter_AW(by: uuid)
                self?.fetchContent_AW()
                self?.storeManagerContent.isNewElementAdded = false
                
                // Calculate the next index after deletion
                let nextIndex = min(currentIndexPath, (self?.content.count ?? 0) - 1 )
                self?.selectedIndexPath = IndexPath(row: nextIndex, section: 0)
                
                if !(self?.content.isEmpty ?? true) {
                    self?.currentPage = nextIndex
                    self?.updateUI_AW(with: nextIndex)
                    self?.scrollToNextItem()
                }
                
                
            }
        })
    }
    private func scrollToNextItem() {
        guard !content.isEmpty else { return }
        let nextIndexPath = IndexPath(item: currentPage, section: 0)
        updateUI_AW(with: currentPage)
        collectionView.scrollToItem(at: nextIndexPath, at: .right, animated: false)
    }

}

//MARK: - UICollectionViewDataSource -

extension EditorViewController_AW: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EditorCollectionViewCell_AW = collectionView.dequeue_AW(id: EditorCollectionViewCell_AW.self, for: indexPath)
        let model = content[indexPath.row]
        if let dataImage = model.preview {
            cell.imgView.image = UIImage(data: dataImage)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate -

extension EditorViewController_AW: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.currentPage = indexPath.row
        let model = content[indexPath.row]
        let vc = EditorSetupViewController_AW()
        vc.modalPresentationStyle = .fullScreen
        vc.typeCharacterEditor = .edit
        storeManagerContent.isNewElementAdded = false
        
        let content: [EditorContentDataModel_AW] = Array(model.content).compactMap({.init(id: $0.id, name: $0.name, type: $0.type_AW(), imgPath: $0.imgPath, isSelected: $0.isSelected)})
        vc.characterPriviewModel_AW = CharacterPriviewModel_AW(content: content, uuid: model.uuid)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.height / 1.5)
         }
}

extension EditorViewController_AW {
    func createLayout_AW() -> UICollectionViewFlowLayout {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            return layout
        }

}
