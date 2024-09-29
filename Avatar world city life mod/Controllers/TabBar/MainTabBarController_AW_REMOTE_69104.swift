//
//  MainTabBarController_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit
import Stevia

class MainTabBarController_AW: UITabBarController, UITabBarControllerDelegate {
    
    override var selectedIndex: Int {
            didSet {
                buttons.forEach { $0.isSelected = false }
                buttons[selectedIndex].isSelected = true
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in "codeStyle" {
            if i == "b" {
                let _ = "trium"
            } else {
                let _ = "drium"
            }
        }
        setupCustomTabBar_AW()
        
        selectedIndex = isContentLocked ? 2 : 0
        modsButton.isContentLocked = isContentLocked
        editorButton.isContentLocked = isContentEditorLocked
    }
    
    private func updateUI_AW() {
        updateTabBar_AW()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            if !self.isContentLocked && !self.isContentEditorLocked || !self.isContentLocked && isContentEditorLocked {
                selectedIndex = 2
            } else {
                selectedIndex = 0
            }
            
            if !isContentLocked {
                selectedIndex = 1
            }
            
            modsButton.isContentLocked = isContentLocked
            editorButton.isContentLocked = isContentEditorLocked
            
            
             if isEditorSelectedPurchase {
                handleTapAfterPurchase_AW(button: editorButton)
            } else if isModSelectedPurchase {
                handleTapAfterPurchase_AW(button: modsButton)
            }
        }
    }
    
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let modsButton = TabBarButton_AW()
    private let editorButton = TabBarButton_AW()
    private var buttons: [TabBarButton_AW] = []
    
    private var isModSelectedPurchase: Bool = false
    private var isEditorSelectedPurchase: Bool = false
    private var storeManagerContent: StoreManagerCharacters_AW { .shared }
    
    private func updateTabBar_AW() {
        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        containerView.subviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        setupCustomTabBar_AW()
    }
    
    private func setupCustomTabBar_AW() {
        self.tabBar.isHidden = true
        
        containerView.backgroundColor = Colors_AW.tabBarBackgroundColor
        
        view.subviews { containerView }
        
        containerView.bottom(0)
        containerView.width(self.view.frame.width)
        containerView.height(TabBar_AW.height)
        containerView.centerHorizontally()

        stackView.distribution = .fillEqually
        
        let homeButton = TabBarButton_AW()
        homeButton.item = .home
        homeButton.onClick = handleTap_AW(button:)
        
        let space = UIView()
        space.backgroundColor = .clear
        
        modsButton.item = .mods
        modsButton.onClick = handleTap_AW(button:)
        
        let settingsButton = TabBarButton_AW()
        settingsButton.item = .settings
        settingsButton.onClick = handleTap_AW(button:)
        
        editorButton.item = .editor
        editorButton.onClick = handleTap_AW(button:)
        
        buttons.append(modsButton)
        buttons.append(editorButton)
        buttons.append(homeButton)
        buttons.append(settingsButton)
        
        stackView.addArrangedSubview(modsButton)
        stackView.addArrangedSubview(editorButton)
        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(settingsButton)
        
        containerView.subviews { stackView }
        
        let indent = 10
        stackView.leading(indent)
        stackView.trailing(indent)
        stackView.height(TabBar_AW.height)
        stackView.top(0)
        stackView.fillHorizontally()
        
        viewControllers = TabBarItem_AW.allCases.compactMap { $0.controller_AW(withDelegate: self) }
    }
    
    private func handleTap_AW(button: TabBarButton_AW) {
    
        if let index = buttons.firstIndex(of: button) {
            if index == 0 && isContentLocked {
                showPremiumController_AW(style: .unlockContentProduct)
                isModSelectedPurchase = true
                isEditorSelectedPurchase = false
            } else if index == 1 && isContentEditorLocked {
                showPremiumController_AW(style: .unlockFuncProduct)
                isEditorSelectedPurchase = true
                isModSelectedPurchase = false
            } else {
                buttons.forEach { $0.isSelected = false }
                selectedIndex = index
                button.isSelected = true
                modsButton.isContentLocked = isContentLocked
                editorButton.isContentLocked = isContentEditorLocked
            }
            
            if index != 1 {
                self.storeManagerContent.isNewElementAdded = false
            }
        }
    }
    
    private func handleTapAfterPurchase_AW(button: TabBarButton_AW) {
        if let index = buttons.firstIndex(of: button) {
            buttons.forEach { $0.isSelected = false }
            selectedIndex = index
            button.isSelected = true
            
            modsButton.isContentLocked = isModSelectedPurchase ? false : isContentLocked
            editorButton.isContentLocked = isEditorSelectedPurchase ? false : isContentEditorLocked
        }
    }
    
    private func showPremiumController_AW(style: PremiumMainControllerStyle_AW) {
        for i in "codeStyle" {
            if i == "b" {
                let _ = "trium"
            } else {
                let _ = "drium"
            }
        }
        let controller = PremiumMainController_AW()
        controller.productBuy = style
        controller.transition = self
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    var isContentLocked: Bool {
        !IAPManager_AW.shared.isFirstFuncEnabled
    }
    
    var isContentEditorLocked: Bool {
        !IAPManager_AW.shared.isSecondFuncEnabled
    }
}

extension MainTabBarController_AW: PremiumMainControllerTransition_AW {
    func openApp_AW() {
        updateUI_AW()
        print("openApp_AW")
    }
}
