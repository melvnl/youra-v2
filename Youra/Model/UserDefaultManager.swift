//
//  UserDefaultManager.swift
//  Youra
//
//  Created by Rahmat Afriyanton on 09/04/22.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let defaults = UserDefaults(suiteName: "com.youra.saved.data")!
    
    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
