//
//  EditorPreviewViewController.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit
import Photos

class EditorPreviewViewController_AW: BaseController_AW {
    
    @IBOutlet weak var previewImage: UIImageView!
    private var storeManagerContent: StoreManagerCharacters_AW { .shared }
    private var downloadedView = LoadingView_AW()

    var type: TypeCharacterEditor_AW?
    var model: CharacterPriviewModel_AW?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupEditorBackground_AW()
        guard let data = model?.preview else { return }
        previewImage.image = UIImage(data: data)
    }
    
    private func showDownloadedAlert_AW() {
        downloadedView = LoadingView_AW(frame: view.bounds)
        downloadedView.configure_AW(with: "Downloaded!")
        downloadedView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(downloadedView)
        
        
        NSLayoutConstraint.activate([
            downloadedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadedView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            downloadedView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            downloadedView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height)
        ])
    }
    
    @IBAction func downloadButtonAction(_ sender: Any) {
        savePreview_AW()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        guard let type = self.type else { return }
        
        switch type {
        case .new:
//            AlertManager_AW.showEditorAlert_AW(with: "Warning", msg: "All your changes will be undone if you leave now.",leadingTitle: "Leave", trailingTitle: "Close") { [weak self] in
//                self?.navigationController?.popToRootViewController(animated: true)
//            } cancelActionHandler: { [weak self] in
            guard let model = self.model else { return }
            self.storeManagerContent.save_AW(model: model)
            self.navigationController?.popToRootViewController(animated: true)
//            }
        case .edit:
//            AlertManager_AW.showEditorAlert_AW(with: "Warning", msg: "All your changes will be undone if you leave now.",leadingTitle: "Leave", trailingTitle: "Close") { [weak self] in
//                self?.navigationController?.popToRootViewController(animated: true)
//            } cancelActionHandler: { [weak self] in
            guard let model = self.model else { return }
            self.storeManagerContent.updateCharacter_AW(with: model)
            self.navigationController?.popToRootViewController(animated: true)
//            }
        }
    }
}

extension EditorPreviewViewController_AW {
  
    private func savePreview_AW() {
        guard let image = combineImages_AW() else { return }
        
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        
        if status == .authorized {
            saveImage_AW(image)
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly, handler: { [weak self] status in
            if status == .authorized {
                self?.saveImage_AW(image)
                return
            }
            
            DispatchQueue.main.async {
                let title =  "Photo Library Issue"
                let message =  "Please check Settings and try again"
                AlertManager_AW.showInfoAlert_AW(with: title, msg: message) {
                    UIApplication.shared.open(.init(string: UIApplication.openSettingsURLString)!)
                }
            }
        })
    }
    
    private func combineImages_AW() -> UIImage? {
        if let preview = self.model?.preview, let composedImage = UIImage(data: preview) {
            return composedImage
        }
        
        return nil
        
    }
    
    private func takeScreenshot_AW(of view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return screenshot
    }
    
    func saveImage_AW(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image_AW(_:didFinishSavingWithError:contextInfo:)), nil)
        
       
    }
    
    @objc func image_AW(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        
        if let error {
            print(error.localizedDescription)
            return
        }
        
        showDownloadedAlert_AW()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.downloadedView.removeFromSuperview()
        }
    }
}
