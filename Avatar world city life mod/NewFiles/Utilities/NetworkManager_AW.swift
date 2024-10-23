//
//  NetworkManager_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation

final class NetworkManager_AW {
    
    class func requestAccessToken_AW(with refreshToken: String,
                                  completion: @escaping (String?) -> Void) {
       
        
        let request: URLRequest = request_AW(with: {
            String
                .init(format: "refresh_token=%@&grant_type=refresh_token",
                      refreshToken)
                .data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error  in
            responseHandler_AW("access_token",
                            data: data,
                            error: error,
                            completion: completion)
        }
        
        task.resume()
    }
    
    class func requestRefreshtoken_AW(with accessCode: String,
                                   completion: @escaping (String?) -> Void) {
       
        
        let request: URLRequest = request_AW(with: {
            String
                .init(format: "code=%@&grant_type=authorization_code",
                      accessCode)
                .data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) {
            data, _, error in
            responseHandler_AW("refresh_token",
                            data: data,
                            error: error,
                            completion: completion)
        }
        
        task.resume()
    }
    
}

// MARK: - Private API

private extension NetworkManager_AW {
    
    class func request_AW(with httpBody: Data) -> URLRequest {
        let base64Str = String
            .init(format: "%@:%@",
                  Keys_AW.App_AW.key_AW.rawValue,
                  Keys_AW.App_AW.secret_AW.rawValue)
            .data(using: .utf8)!
            .base64EncodedString()
        let token = String(format: "Basic %@", base64Str)
        var request = URLRequest(url: .init(string: Keys_AW.App_AW.link_AW.rawValue)!)
        
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        return request
    }
    
    class func responseHandler_AW(_ key: String,
                               data: Data?,
                               error: Error?,
                               completion: @escaping (String?) -> Void) {
        if let error { print(error.localizedDescription) }
        
        
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: data ?? Data())
                as? [String: Any] {
                print(jsonDict)
            }
        } catch {
            print(error)
        }
        
        do {
            guard let data,
                  let jsonDict = try JSONSerialization.jsonObject(with: data)
                    as? [String: Any],
                  let accessToken = jsonDict[key] as? String
            else {
                completion(nil)
                return
            }
            
            completion(accessToken)
        } catch let error {
            print(error.localizedDescription)
            
            completion(nil)
        }
    }
    
}
