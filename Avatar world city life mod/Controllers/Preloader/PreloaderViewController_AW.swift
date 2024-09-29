//
//  PreloaderViewController.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit
import Lottie

protocol PreloaderViewControllerTransition_AW: AnyObject {
    func didEndUploading_AW()
}

class PreloaderViewController_AW: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    weak var transition: PreloaderViewControllerTransition_AW?
    private var dropBox: DBManager_AW { .shared }
    private var storeManager: StoreManager_AW { .shared }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.play()
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        ReachabilityManager_AW.shared.setupReachabilityObserver_AW()
        ReachabilityManager_AW.shared.isActiveInternet = { [weak self] in
            self?.connectToDropbox_AW()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
        animationView.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        connectToDropbox_AW()
    }
    
}
// MARK: - Private API

private extension PreloaderViewController_AW {
    
    private func connectToDropbox_AW() {
        
        dropBox.connect_AW() { [weak self] _ in
            self?.fetchModel_AW()
        }
    }
    
    private func fetchModel_AW() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if DBManager_AW.shared.isAllModelsUploaded_AW() {
            dispatchGroup.leave()
        } else {
            DBManager_AW.shared.fetchModel_AW {
                dispatchGroup.leave()
                print("🔴 fetching model")
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("fetching model content...")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.navigateToMainMenu_AW()
            }
        }
    }
    
    private func navigateToMainMenu_AW() {
       
        self.transition?.didEndUploading_AW()
    }
    
}


