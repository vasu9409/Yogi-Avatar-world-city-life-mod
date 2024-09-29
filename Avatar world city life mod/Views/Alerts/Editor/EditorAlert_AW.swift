//
//  EditorAlert.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

final class EditorAlert_AW: UIView {
    
    @IBOutlet weak var generallView: UIView!
    @IBOutlet weak var lbMsg: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var leadingButton: UIButton!
    @IBOutlet weak var trailingButton: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var widthConstarint: NSLayoutConstraint!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupUI_AW()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
        setupUI_AW()
    }
    
    private func setupUI_AW() {
       
        
        self.nibSetup_AW()
        self.bgView.roundCorners_AW(radius: 24)
        self.bgView.addBorder_AW(color: .white, width: 1)
        
        layerView.addBorder_AW(color: Colors_AW.contentBorderColor, width: 3)
        layerView.roundCorners_AW(radius: 24)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap_AW(_:)))
        generallView.addGestureRecognizer(tap)
        
        widthConstarint.constant = self.iPad ? 390 : UIScreen.main.bounds.size.width - 16
    }
    
    private var doneActionHandler: (()-> Void)?
    private var cancelActionHandler: (()-> Void)?
    
    func configure_AW(with title: String,
                   msg: String,
                   leadingTitle: String = "Cancel",
                   trailingTitle: String = "Delete",
                   doneActionHandler: (() -> Void)?,
                   cancelActionHandler: (() -> Void)?
    ) {
       
        self.lbMsg.text = msg
        self.leadingButton.setTitle(leadingTitle, for: .normal)
        self.trailingButton.setTitle(trailingTitle, for: .normal)
        self.lbTitle.isHidden = title.isEmpty
        self.lbTitle.text = title
        self.doneActionHandler = doneActionHandler
        self.cancelActionHandler = cancelActionHandler
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        
        doneActionHandler?()
        removeFromSuperview()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        cancelActionHandler?()
        removeFromSuperview()
    }
    
    
    @objc func handleTap_AW(_ sender: UITapGestureRecognizer? = nil) {
        print("handleTap_AW")
        removeFromSuperview()
    }
}
