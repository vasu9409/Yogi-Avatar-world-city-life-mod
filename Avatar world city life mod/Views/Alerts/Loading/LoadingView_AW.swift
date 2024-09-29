//
//  LoadingView.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

final class LoadingView_AW: UIView {
    
    @IBOutlet weak var generallView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
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

    }
    
    
    func configure_AW(with title: String = "Loading...") {
       
        self.lbTitle.text = title
    }
    
}
