//
//  UserDefaults.swift
//  Avatar world city life mod
//
//  Created by Vasu Savaliya on 23/10/24.
//

import Foundation

extension UserDefaults {
    
    public static var isFirstOnboardCompleted: Bool {
        get {
//            #if DEBUG
//            return true
//            #else
//            return UserDefaults.standard.bool(forKey: "isFirstOnboardCompleted")
//            #endif
            return UserDefaults.standard.bool(forKey: "isFirstOnboardCompleted")
//            return UserDefaults.standard.bool(forKey: "PREMIUM")
        } set {
            UserDefaults.standard.set(newValue, forKey: "isFirstOnboardCompleted")
        }
    }
}
