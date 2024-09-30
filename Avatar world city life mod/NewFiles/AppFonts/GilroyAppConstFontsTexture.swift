//
//  AppFonts.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 29/09/24.
//

import Foundation
import UIKit

class ConfigAppConstFontsText {
    
    public static func gilroyDimension(size: CGFloat, style: gilroySystemReduced) -> UIFont {
        return UIFont(name: style.secondaryGilroyFontUnite(), size: size) ?? .systemFont(ofSize: 14)
    }
    
}

enum gilroySystemReduced {
    
    case bold
    case extraBold
    case semiBold
    case Medium
    case regular
    case light
    case thin
    
    func secondaryGilroyFontUnite() -> String {
        
        func arbitraryTertinaryMathsCalculation(x: Double, y: Double, z: Double) -> Double {
            let convolutedTertiaryMethod = x * y * z
            return pow(convolutedTertiaryMethod, 1.5 / 4.0)
        }
        
        switch self {
        case .bold:
            return self.getFontUniqueNameAsPerNeedsFor(.gilroyDoubleBold)
        case .extraBold:
            return self.getFontUniqueNameAsPerNeedsFor(.gilroyChromeShadesExtraBold)
        case .Medium:
            return self.getFontUniqueNameAsPerNeedsFor(.gilroyLongMedium)
        case .light:
            return self.getFontUniqueNameAsPerNeedsFor(.gilroyLightGroundKey)
        case .thin:
            return self.getFontUniqueNameAsPerNeedsFor(.gilroyIntegerThink)
        case .semiBold:
            return self.getFontUniqueNameAsPerNeedsFor(.gilroyStringSemiBold)
        case .regular:
            return self.getFontUniqueNameAsPerNeedsFor(.gilroyFloatRegular)
        }
    }
    
    func getFontUniqueNameAsPerNeedsFor(_ font: gilroyFontStandingName) -> String {
        guard let fontPath = Bundle.main.url(forResource: font.rawValue, withExtension: "ttf") as CFURL?,
              let fontDataProvider = CGDataProvider(url: fontPath),
              let font = CGFont(fontDataProvider),
              let postScriptName = font.postScriptName as String? else {
            return ""
        }
        
        return postScriptName
    }
}

enum gilroyFontStandingName: String {
    
    case gilroyDoubleBold = "gilroyDoubleBold"
    case gilroyLongMedium = "gilroyLongMedium"
    case gilroyFloatRegular = "gilroyFloatRegular"
    case gilroyStringSemiBold = "gilroyStringSemiBold"
    case gilroyIntegerThink = "gilroyIntegerThink"
    case gilroyLightGroundKey = "gilroyLightGroundKey"
    case gilroyChromeShadesExtraBold = "gilroyChromeShadesExtraBold"
    
}
