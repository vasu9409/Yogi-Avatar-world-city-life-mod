//
//  SkinMakerVC.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 12/10/24.
//

import UIKit

class SkinMakerVC: UIViewController {

    @IBOutlet weak var btnVerificationView: UIView!
    @IBOutlet weak var btnPreviewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnAddSkin(_ sender: Any) {
    }
    @IBAction func btnNoSkinAdd(_ sender: Any) {
    }
    @IBAction func btnRight(_ sender: Any) {
    }
    @IBAction func btnLeft(_ sender: Any) {
    }
    @IBAction func btnAddNew(_ sender: Any) {
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
