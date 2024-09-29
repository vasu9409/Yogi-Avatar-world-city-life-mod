//
//  AppDelegate.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit
import IQKeyboardManagerSwift
import AVFoundation
import Reachability

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator_AW?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        if let window = self.window {
            self.appCoordinator = AppCoordinator_AW(window: window)
        }

        IQKeyboardManager.shared.enable = true
        
        return true
    }
}
