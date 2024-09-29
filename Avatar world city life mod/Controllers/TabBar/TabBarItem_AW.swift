//
//  TabBarItem_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//


import UIKit

enum TabBarItem_AW {
    case mods
    case home
    case editor
    case settings

}

extension TabBarItem_AW {
    static var allCases: [TabBarItem_AW] = [
        .mods,
        .editor,
        .home,
        .settings,
    ]
    
    var title: String {
        switch self {
        case .mods: return "Mods"
        case .editor: return "Skin Maker"
        case .home: return "House Ideas"
        case .settings: return "Settings"
            
        }
    }
    
    var image: UIImage? {
        switch self {
        case .mods: return UIImage(named: "moods")
        case .editor: return UIImage(named: "editor")
        case .home: return UIImage(named: "home")
        case .settings: return UIImage(named: "settings")
        
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .mods: return UIImage(named: "moodsActive")
        case .editor: return UIImage(named: "editorActive")
        case .home: return UIImage(named: "homeActive")
        case .settings: return UIImage(named: "settingsActive")
        }
    }
    
    var index: Int {
        switch self {
        case .home: return 2
        case .settings: return 3
        case .mods: return 0
        case .editor: return 1
        }
    }
    
     func homeVC_AW() -> UIViewController {
          
        return  HomeViewController_AW()
    }
    
     func modsVC_AW() -> UIViewController {
          
        return  ModsViewController_AW()
    }
    
     func editorVC_AW() -> UIViewController {
          
         return EditorViewController_AW()
    }
    
    func settings_AW() -> UIViewController {
       
       return  SettingsViewController_AW()
   }

    func controller_AW(withDelegate delegate: MainTabBarController_AW) -> UIViewController? {
       
            switch self {
            case .home: return homeVC_AW()
            case .settings: return settings_AW()
            case .mods: return modsVC_AW()
            case .editor: return editorVC_AW()
                
            }
        }
}
