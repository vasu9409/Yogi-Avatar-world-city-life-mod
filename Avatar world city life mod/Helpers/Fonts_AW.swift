//
//  Fonts_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import UIKit

final class Fonts_AW {
    
    enum FontStyle_AW: String {
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
        case extraBold = "ExtraBold"
    }

    
    class func defaultFont_AW(size: CGFloat) -> UIFont {
       
        
        return UIFont(name:"KristenITC-Regular", size: size) ?? .systemFont(ofSize: 5)
    }
    
    class func interFont_AW(for style: FontStyle_AW, size: CGFloat) -> UIFont {
       
        return UIFont(name:"Inter-\(style.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: 18)
    }
    
    class func balooFont_AW(size: CGFloat) -> UIFont {
       
        return UIFont(name:"BalooThambi-Regular", size: size) ?? .systemFont(ofSize: 18)
    }
    
}
