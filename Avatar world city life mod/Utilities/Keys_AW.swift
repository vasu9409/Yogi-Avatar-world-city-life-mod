//
//  Keys_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
struct Keys_AW {

    enum App_AW: String {
        case accessCode_AW = "DFksy546qT0AAAAAAAAFF7tp4MfRYdkadMYLazjTp5o",
             key_AW = "qv0anezfg7yzqcm",
             secret_AW = "oa60j2fhkk1qva5",
             link_AW = "https://api.dropboxapi.com/oauth2/token"
    }
    
    enum Path_AW: String {
        case houseIdeas = "houseideas",
             mods = "mods",
             content = "content"
        
        var contentPath: String {
            .init(format: "/%@/%@.json", rawValue, rawValue)
        }
        
        func getPath_AW(forMarkup tag: String) -> String {
             
            return String(format: "/%@/%@/content.json", rawValue, tag)
        }
        
       
        func getPathContent_AW(forMarkup tag: String) -> String {
             
            return String(format: "/%@/%@", rawValue, tag)
        }
    }
}
