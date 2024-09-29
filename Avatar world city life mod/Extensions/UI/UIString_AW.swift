//
//  UIString_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit
typealias str = String
extension str {
    
func height_AW(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.text = self
    label.font = font
    label.sizeToFit()

    return label.frame.size.height
 }
}

