

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
    
    static var MVTMindFreshnerQuestionsSave: [The8Ua8Onb] {
        get {
            if let data = UserDefaults.standard.object(forKey: "MindVaultResultQUESTIONSBOOKMARKNowData") as? Data {
                do {
                    let MVTDeocoder = JSONDecoder()
                    let places = try MVTDeocoder.decode([The8Ua8Onb].self, from: data)
                    return places
                } catch {
                    print(error.localizedDescription)
                    print(String(describing: error))
                }
            }
            return []
        } set {
            do {
                let encodedData = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(encodedData, forKey: "MindVaultResultQUESTIONSBOOKMARKNowData")
            } catch {
                print(error.localizedDescription)
                print(String(describing: error))
            }
        }
    }
    
    static var AvatarModsFavData: [E8V] {
        get {
            if let data = UserDefaults.standard.object(forKey: "AvatarModsFavData") as? Data {
                do {
                    let MVTDeocoder = JSONDecoder()
                    let places = try MVTDeocoder.decode([E8V].self, from: data)
                    return places
                } catch {
                    print(error.localizedDescription)
                    print(String(describing: error))
                }
            }
            return []
        } set {
            do {
                let encodedData = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(encodedData, forKey: "AvatarModsFavData")
            } catch {
                print(error.localizedDescription)
                print(String(describing: error))
            }
        }
    }
}
