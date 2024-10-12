//
//  UIViewBase.swift
//  Bloodmeter
//
//  Created by VASU SAVALIYA on 02/12/22.
//

import UIKit

class UIViewBase: UIView {

    // ====================================
    // MARK:-
    // MARK: - Variables
    // ====================================
    var contentView: UIView!

    var nibName: String {
        return String(describing: type(of: self))
    }
    
    // ====================================
    // MARK:-
    // MARK: - Override Methods
    // ====================================
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    // ====================================
    // MARK:-
    // MARK: - Custome Function
    // ====================================
    private func setupView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
