//
//  ViewController_AW+Extensions.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import MBProgressHUD
import UIKit

typealias ViewController_AW = UIViewController

extension ViewController_AW {
    
    class func loadFromNib_AW() -> Self {
        .init(nibName: String(describing: Self.self), bundle: .main)
    }
    
   
    func showProgressHud_AW(message: String = "Loading...",
                 alpha: CGFloat = 0.8,
                 animated: Bool = true,
                 graceTime: Double = 0.1,
                 minShowTime: Double = 0.5,
                 mode: MBProgressHUDMode = .indeterminate,
                 completion: EmptyClosureType? = nil) {
        
       
        hideProgressHud_AW(animated: false)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let hud = MBProgressHUD(view: self.view)
            if !self.view.subviews.contains(where: { $0 is MBProgressHUD }) {
                self.view.addSubview(hud)
            }
            hud.backgroundView.alpha = alpha
            hud.label.text = message
            hud.graceTime = graceTime
            hud.minShowTime = minShowTime
            hud.mode = mode
            hud.completionBlock = {
                hud.removeFromSuperview()
                completion?()
            }
            hud.show(animated: animated)
        }
    }
    
    func hideProgressHud_AW(animated: Bool = true) {
       
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var huds = self.view.subviews.compactMap { $0 as? MBProgressHUD }
            guard !huds.isEmpty else { return }
            let last = huds.removeLast()
            huds.forEach { $0.hide(animated: false) }
            last.hide(animated: animated)
        }
    }
}
