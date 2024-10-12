//
//  PopUPView.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 09/10/24.
//

import UIKit
import Blurberry

class PopUPView: UIViewController {

    @IBOutlet weak var nameBackView: UIView!
    @IBOutlet weak var popupnameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameBackView.layer.cornerRadius = IS_IPAD ? 44 : 24
        applyBlur(self.view)
        
    }
}
