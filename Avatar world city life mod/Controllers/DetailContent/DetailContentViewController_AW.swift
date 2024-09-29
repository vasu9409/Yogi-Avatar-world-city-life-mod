//
//  DetailContentViewController.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit
import Photos

class DetailContentViewController_AW: BaseController_AW {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var contentImgView: UIImageView!
    
    private let viewModel: DetailViewModel_AW = DetailViewModel_AW()
    private var loadingView = LoadingView_AW()

    var completionBack: ((ListDTO_AW?) -> Void)?
    var model: ListDTO_AW?
    var type: ContentType_AW?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configure_AW()
        bindData_AW()
        setupCollection_AW()
    }
     
    private func bindData_AW() {
        viewModel.onReload = { [weak self] in
            self?.tableview.reloadData()
        }
    }
    
    private func showLoading_AW() {
        loadingView = LoadingView_AW(frame: UIScreen.main.bounds)
        loadingView.configure_AW(with: "Downloaded!")
        loadingView.translatesAutoresizingMaskIntoConstraints = false

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.addSubview(loadingView)
            loadingView.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: keyWindow.centerYAnchor).isActive = true
            loadingView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
            loadingView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height).isActive = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.removeLoading_AW()
        }
    }

    
    private func removeLoading_AW() {
       
           loadingView.removeFromSuperview()
       }
    
    private func setupCollection_AW() {
        tableview.dataSource = self
        tableview.backgroundColor = .clear
        tableview.register_AW(cell: DetailContentTableViewCell_AW.self)
    }
    
    private func shareAPKFileUsingActivityViewController_AW(apkFileURL: URL) {
       
        
        
        let activityViewController = UIActivityViewController(activityItems: [apkFileURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // Specify the source view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        activityViewController.popoverPresentationController?.permittedArrowDirections = [] // Set the arrow directions

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func configure_AW() {
        guard let model = self.model else { return }
        viewModel.setupContent_AW(with: model)
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        if let imgData = model.data  {
            contentImgView.image = UIImage(data: imgData)
        }
        checkmarkButton.setBackgroundImage(model.isFavorite ? UIImage(named: "button_checkmark") : UIImage(named: "button_checkmark_inactive"), for: .normal)
    }
    
    @IBAction func downloadButtonTapped(_ sender: Any) {
        switch type {
        case .mod:
            guard let apkPath = model?.apkPath else {
                return
            }
            
            self.showProgressHud_AW()
            
            viewModel.fetchIpa_AW(by: apkPath) { [weak self] url in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self?.hideProgressHud_AW()
                    self?.shareAPKFileUsingActivityViewController_AW(apkFileURL: url)
                })
            }
        default:
            guard let data = model?.data else { return }
            savePreviewImage(with: UIImage(data: data))
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.completionBack?(viewModel.content.first)
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailContentViewController_AW: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DetailContentTableViewCell_AW  = tableview.dequeueReusableCell(withIdentifier: DetailContentTableViewCell_AW.identifier, for: indexPath) as? DetailContentTableViewCell_AW else { return UITableViewCell() }
        let model = viewModel.content[indexPath.row]
        cell.configure_AW(with: model)
        cell.delegate = self
        return cell
    }

}

extension DetailContentViewController_AW: DetailContentDelegate_AW {
    func makeIsFavorite_AW(with model: ListDTO_AW) {
        guard let type = self.type else { return }
        viewModel.updateIsFavorites_AW_AW(for: model, type: type)
    }
}

extension DetailContentViewController_AW {
  
    func savePreviewImage(with image: UIImage?) {
         
        guard let image = image else { return }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly, handler: { [weak self] status in
            if status == .authorized {
                self?.saveImage(image)
                return
            }
            
            DispatchQueue.main.async {
                let title =  "Warning:"
                let message =  "Without photo access, you cannot\ncontinue."
                AlertManager_AW.showEditorAlert_AW(with: title, msg: message, leadingTitle: "Confirm", trailingTitle: "Cancel") {
                    UIApplication.shared.open(.init(string: UIApplication.openSettingsURLString)!)
                }
            }
        })
    }
    
    private func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image_AW(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image_AW(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            print("Error saving image to Photos Library: \(error.localizedDescription)")
            return
        }
        
        showLoading_AW()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadingView.removeFromSuperview()
        }
    }
}

