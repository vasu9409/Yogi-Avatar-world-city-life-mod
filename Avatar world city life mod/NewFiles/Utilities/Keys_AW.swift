//
//  Keys_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
struct Keys_AW {

    enum App_AW: String {
        case accessCode_AW = "230EfwOzUA4AAAAAAAAAAX1huz1beG9_FqyWNawL9N2lS8DvsofqB1oMgkuogf6S",
             key_AW = "oosigu298z2u6wf",
             secret_AW = "f33dcrdbt7xju5v",
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
