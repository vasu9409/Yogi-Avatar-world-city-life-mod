//
//  EditorSetupViewController.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

enum TypeCharacterEditor_AW: Hashable {
    case new,
         edit
}

class EditorSetupViewController_AW: BaseController_AW {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var characterEditorImage: CharacterEditorImage_AW!
    
    let viewModel: EditorSetupViewModel_AW = EditorSetupViewModel_AW()
    
    private var storeManagerContent: StoreManagerCharacters_AW { .shared }
    private var dropbox: DBManager_AW { .shared }
    var typeCharacterEditor: TypeCharacterEditor_AW?
    var characterPriviewModel_AW: CharacterPriviewModel_AW?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection_AW()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupEditorBackground_AW()
        bindData_AW_AW()
        viewModel.loadContent_AW(with: self.dropbox.contentManager.fetchEditorContent_AW())
        viewModel.makeSelected_AW(type: .body)
        
        guard let preview = characterPriviewModel_AW else { return }
        viewModel.loadSelectedContent_AW(with: preview.content)
    }
    
    private func setupCollection_AW() {
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.allowsMultipleSelection = false
        contentCollectionView.showsVerticalScrollIndicator = false
        contentCollectionView.showsHorizontalScrollIndicator = false
        contentCollectionView.collectionViewLayout = contentCollectionViewLayout_AW(item: 80)
        contentCollectionView.register_AW([ContentCollectionViewCell.identifier])
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.allowsMultipleSelection = false
        categoryCollectionView.showsVerticalScrollIndicator = false
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.collectionViewLayout = setupCategoryLayout_AW()
        
        categoryCollectionView.register_AW([CategoryCollectionViewCell.identifier])
        
    }
    
    private func contentCollectionViewLayout_AW(item size: CGFloat) -> UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let inset:CGFloat = self.iPad ? 55 : 20
        collectionViewLayout.sectionInset = .init(top: .zero,
                                                  left: inset,
                                                  bottom: .zero,
                                                  right: inset)
        collectionViewLayout.itemSize = .init(width: size, height: size)
        
        return collectionViewLayout
    }
    
    func setupCategoryLayout_AW()  -> UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.estimatedItemSize = CGSize(width: 70, height: 40)
        collectionViewLayout.minimumLineSpacing = self.iPad ? 25 : 10
        let inset: CGFloat = self.iPad ? 55 : 20
        collectionViewLayout.sectionInset = .init(top: .zero,
                                                  left: inset,
                                                  bottom: .zero,
                                                  right: inset)
        return collectionViewLayout
    }
    
    
    private func bindData_AW_AW() {
        
        viewModel.onLoadContent_AW = { [weak self] in
            self?.setupImageView_AW()
            self?.categoryCollectionView.reloadData()
        }
        
        viewModel.onUpdateColor = { [weak self] model in
            self?.characterEditorImage.changeStatus_AW(with: model)
        }
        
        viewModel.onUpdateContent_AW = { [weak self] model in
            self?.characterEditorImage.changeStatus_AW(with: model)
            self?.contentCollectionView.reloadData()
        }
        
        viewModel.onUpdateCategory_AW = { [weak self] model in
            self?.categoryCollectionView.reloadData()
            self?.contentCollectionView.reloadData()
        }
    }
    
    private func setupImageView_AW() {
        characterEditorImage.setupContents_AW(contents: viewModel.allContent)
    }
    
    private func showPreview_AW(with model: CharacterPriviewModel_AW?, type: TypeCharacterEditor_AW) {
        let vc = EditorPreviewViewController_AW()
        vc.model = model
        vc.type = type
        navigationController?.pushViewController(vc, animated: true)
    }
        
    
    @IBAction func doneButtonAction(_ sender: Any) {
        guard let type = typeCharacterEditor else { return }
        switch type {
        case .new:
            let uuid = UUID()
            var preview = characterEditorImage.mergeImages_AW()
            let model = CharacterPriviewModel_AW(content: viewModel.allContent,
                                                    uuid: uuid,
                                                    preview: preview)
            
            showPreview_AW(with: model, type: .new)
            preview = nil
        case .edit:
            guard let model = self.characterPriviewModel_AW else { return }
            var preview = characterEditorImage.mergeImages_AW()
            
            let prevModel = CharacterPriviewModel_AW(content: viewModel.allContent,
                                                        uuid: model.uuid,
                                                        preview: preview)
            showPreview_AW(with: prevModel, type: .edit)
            preview = nil
        }
    }

    @IBAction func backButtonAction(_ sender: Any) {
        AlertManager_AW.showEditorAlert_AW(with: "Warning", msg: "All your changes will be undone if you leave now.", leadingTitle: "Leave", trailingTitle: "Close", doneActionHandler:  {
            self.navigationController?.popViewController(animated: false)
        })
    }
}

//MARK: - UICollectionViewDataSource -

extension EditorSetupViewController_AW: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return viewModel.category.count
        case contentCollectionView:
            return viewModel.content.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell: CategoryCollectionViewCell = collectionView.dequeue_AW(id: CategoryCollectionViewCell.self, for: indexPath)
            let category = viewModel.category[indexPath.row]
            cell.configure_AW(with: category)
            return cell
        case contentCollectionView:
            let cell = collectionView.dequeue_AW(id: ContentCollectionViewCell.self, for: indexPath)
            let content = viewModel.content[indexPath.row]
            cell.configure_AW(with: content)
            return cell
        default:
            let cell: ContentCollectionViewCell = collectionView.dequeue_AW(id: ContentCollectionViewCell.self, for: indexPath)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate -

extension EditorSetupViewController_AW: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        switch collectionView {
        case categoryCollectionView:
            
            let category = viewModel.category[indexPath.row]
            viewModel.makeSelected_AW(type: category.type)
        case contentCollectionView:
            let content = viewModel.content[indexPath.row]
            viewModel.makeSelectedContent_AW(model: content)
        default: break
        }
    }
}

