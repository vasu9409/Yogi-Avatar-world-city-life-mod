//
//  DBManager_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import Combine
import SwiftyDropbox
import UIKit

final class DowringBillFromBrotherManagerGirlStep: NSObject {
    
    static let shared = DowringBillFromBrotherManagerGirlStep()
    
    var client: DropboxClient?
    
}

extension DowringBillFromBrotherManagerGirlStep {
    
    func connect_AW(completion: ((DropboxClient?) -> Void)? = nil) {
        print("DBManager_AW - connect_AW!")
        
        UserDefaults
            .standard
            .setValue("230EfwOzUA4AAAAAAAAAAX1huz1beG9_FqyWNawL9N2lS8DvsofqB1oMgkuogf6S",
                      forKey: "refresh_token")
        
        let connect_AWionBlock: (_ accessToken: String) -> Void = {
            [unowned self] accessToken in
            
            let client = connect_AWoDropbox(with: accessToken)
            
            print("DBManager_AW - connect_AWed!")
            
            completion?(client)
        }
        
        let refreshTokenBlock: (_ refreshToken: String) -> Void = {
            refreshToken in
            NetworkManager_AW.requestAccessToken_AW(with: refreshToken) {
                accessToken in
                guard let accessToken else {
                    print("DBManager_AW - Error acquiring access token")
                    
                    return
                }
                
                print("DBManager_AW - AccessToken: \(accessToken)")
                
                connect_AWionBlock(accessToken)
            }
        }
        
        if let refreshToken = UserDefaults
            .standard
            .string(forKey: "refresh_token") {
            refreshTokenBlock(refreshToken)
            return
        }
        
        NetworkManager_AW
            .requestRefreshtoken_AW(with: Keys_AW.App_AW.accessCode_AW.rawValue) {
                refreshToken in
                guard let refreshToken else {
                    completion?(nil)
                    return
                }
                
                UserDefaults.setValue(refreshToken, forKey: "refresh_token")
                print("DBManager_AW - Refreshtoken: \(refreshToken)")
                
                refreshTokenBlock(refreshToken)
            }
    }
    
    func connect_AWoDropbox(with accessToken: String) -> DropboxClient {
        let client = DropboxClient(accessToken: accessToken)
        
        self.client = client
        
        return client
    }
}
