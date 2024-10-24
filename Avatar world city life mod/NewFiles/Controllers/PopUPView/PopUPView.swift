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
    
    var nameLabelText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameBackView.layer.cornerRadius = IS_IPAD ? 44 : 24
        applyBlur(self.view)
        
        self.popupnameLabel.text = self.nameLabelText
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.dismiss(animated: false) {
                if let homeViewController = self.navigationController?.viewControllers.first(where: { $0 is SkinMakerVC }) {
                    self.navigationController?.popToViewController(SkinMakerVC(), animated: true)
                }
            }
        })
    }
}
