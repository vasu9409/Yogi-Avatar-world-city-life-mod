//
//  Coordinators_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit
import Reachability

class ConsiderForApplicationFindabkeCoordinatorAsOfNow {
    private var window: UIWindow
    private let serviceHolder = ServiceHolder_AW.shared
    private var reachability: Reachability?
    
    var viewController: UIViewController?
    
    init(window: UIWindow) {
        self.window = window
        startInitialServices_AW()
        startPreloader_AW()
    }
    
    func startPreloader_AW() {
        let vc = PreloaderVC()
        vc.transition = self
        let navigationController = UINavigationController(rootViewController: vc)
        self.viewController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        self.window.rootViewController = navigationController
    }
    
    func startMain_AW() {
        
        let vc = HomeVC()
        let navigationController = UINavigationController(rootViewController: vc)
        self.viewController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        
        UserDefaults.isFirstOnboardCompleted = true
        
        self.window.rootViewController = navigationController
    }
}

//MARK: - PreloaderTransition -

extension ConsiderForApplicationFindabkeCoordinatorAsOfNow: PreloaderViewControllerTransition {
    func didEndUploading() {
        startMain_AW()
    }
}


// MARK: - Services routine

extension ConsiderForApplicationFindabkeCoordinatorAsOfNow {
    
    private func startInitialServices_AW() {
        let contentService = ContentService_AW()
        serviceHolder.add_AW(ContentService_AW.self, for: contentService)
    }
    
    private func cleanServices_AW() {
       
        startInitialServices_AW()
    }
}
