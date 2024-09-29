//
//  AlertManager.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

class AlertManager_AW {
    
    static func showEditorAlert_AW(with title: String,
                                msg: String,
                                leadingTitle: String = "Cancel",
                                trailingTitle: String = "Delete",
                                doneActionHandler: (() -> Void)?,
                                cancelActionHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            let customAlertView = EditorAlert_AW(frame: window.frame)
            customAlertView.configure_AW(with: title, msg: msg, leadingTitle: leadingTitle, trailingTitle: trailingTitle,
                                      doneActionHandler: doneActionHandler, cancelActionHandler: cancelActionHandler)
            window.addSubview(customAlertView)
        }
    }
    
    static func showInfoAlert_AW(with title: String ,msg: String, doneActionHandler: (() -> Void)?) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            let customAlertView = InfoAlert_AW(frame: window.frame)
            customAlertView.configure_AW(with: title, msg: msg, doneActionHandler: doneActionHandler)
            window.addSubview(customAlertView)
        }
    }
    
}



