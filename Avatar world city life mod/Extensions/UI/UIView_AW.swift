//
//  UIView_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import UIKit

typealias View = UIView

extension View {
    class var identifier: String {
        String(describing: self)
    }
    
    class var nib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    func applyLeftToRightGradient_AW(colors: [UIColor]) {
       
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(rect: bounds)
        shapeLayer.path = path.cgPath
        gradientLayer.mask = shapeLayer
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static var describing: String {
        return String(describing: self)
    }
    
    func nibSetup_AW() {
        let subView = loadViewFromNib_AW()
        setupView_AW(subView: subView)
    }
    
    func loadViewFromNib_AW() -> View {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? View else {
            return View()
        }
        return nibView
    }
    
    func nibControlSetup_AW() {
       
        let subView = loadControlFromNib_AW()
        setupView_AW(subView: subView)
    }
    
    
    func loadControlFromNib_AW() -> UIControl {
       
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIControl else {
            return UIControl()
        }
        return nibView
    }
    
   
    private func setupView_AW(subView: View) {
        
       
        backgroundColor = .clear
        subView.frame = bounds
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subView)
        self.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: 0).isActive = true
        self.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: 0).isActive = true
        subView.backgroundColor = .clear
    }
    
    var halfWidth: CGFloat {
        return self.bounds.width / 2
    }
    
    var halfHeight: CGFloat {
        return self.bounds.height / 2
    }
    
    static func createEmpty_AW() -> View {
       
        let view = View(frame: CGRect(x: 0, y: 0, width: 0, height: -1))
        view.backgroundColor = .white
        return view
    }
    
    
    func setCornerRadius_AW(_ radius: Double) {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.masksToBounds = true
    }
    
    func roundCorners_AW() {
       
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func addBorder_AW(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func roundCorners_AW(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func update_AW(isHidden value: Bool) {
         
        isHidden = value
        isUserInteractionEnabled = !value
    }
    
    func hide_AW() {
       
        if !isHidden { update_AW(isHidden: true) }
    }
    
    func show_AW() {
        if isHidden { update_AW(isHidden: false) }
    }
    
    var iPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
}
