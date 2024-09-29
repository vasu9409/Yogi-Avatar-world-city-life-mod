//
//  BaseController_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import SnapKit
import UIKit

class BaseController_AW: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setDefaultBackground_AW()
    }
    
    deinit { print("DEINIT - \(String(describing: Self.self))") }
    
    func bottomInset() -> CGFloat {
       
        
        return TabBar_AW.height
    }
    
    
    func setupEditorBackground_AW() {
        seteditorBackground_AW()
    }
    
    var iPad: Bool { view.iPad }
}


// MARK: - Private API

private extension BaseController_AW {
    
    func setDefaultBackground_AW() {
        
       
        let defaultBackground = UIImageView(image: #imageLiteral(resourceName: "background"))
        
        view.insertSubview(defaultBackground, at: .zero)
        
        defaultBackground.contentMode = .scaleAspectFill
        defaultBackground.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func seteditorBackground_AW() {
        let image = self.iPad ? #imageLiteral(resourceName: "ipadBg") :  #imageLiteral(resourceName: "EditorBackground")
        let defaultBackground = UIImageView(image: image)
        
        view.insertSubview(defaultBackground, at: 1)
        
        defaultBackground.contentMode = .scaleToFill
        defaultBackground.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
}
