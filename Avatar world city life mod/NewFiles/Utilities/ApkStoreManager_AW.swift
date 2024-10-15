//
//  ApkStoreManager_AW.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
class ApkStoreManager_AW {
    static let shared = ApkStoreManager_AW()
    
    // Method to save APK file to FileManager
    func saveAPKFileToDocumentDirectory_AW(data: Data, path: String) {
       
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("\(path).apk")
            do {
                try data.write(to: fileURL)
                print("APK file saved: \(fileURL.path)")
            } catch {
                print("Error saving APK file:", error)
            }
        }
    }
    
    // Method to fetch APK file from FileManager
    func fetchAPKFileFromDocumentDirectory_AW(path: String) -> URL? {
       
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("\(path).apk")
            return fileURL
        }
        return nil
    }
    
    func checkAPKIfFileExistsInDocumentDirectory_AW(path: String) -> Bool {
       
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("\(path).apk")
            return FileManager.default.fileExists(atPath: fileURL.path)
        }
        return false
    }
}
