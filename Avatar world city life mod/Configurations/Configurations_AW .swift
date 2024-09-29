//
//  Configurations.swift
//  template
//
//  Created by Alex N
//

import Foundation
import CoreText

enum Configurations_AW {
    static let subFontUrl = Bundle.main.url(forResource: "sub", withExtension: "ttf")!
    
    static let termsLink: String = "https://www.google.com"
    static let policyLink: String = "https://www.google.com"
    
    static func getSubFontName_AW() -> String {
     
        let fontPath = Configurations_AW.subFontUrl.path as CFString
        let fontURL = CFURLCreateWithFileSystemPath(nil, fontPath, CFURLPathStyle.cfurlposixPathStyle, false)
        
        guard let fontDataProvider = CGDataProvider(url: fontURL!) else {
            return ""
        }
        
        if let font = CGFont(fontDataProvider) {
            if let postScriptName = font.postScriptName as String? {
                return postScriptName
            }
        }
        return ""
    }
}

enum ConfigurationMediaSub_AW {
    static let nameFileVideoForPhone = "phone"
    static let nameFileVideoForPad = "pad"
    static let videoFileType = "mp4"
}
