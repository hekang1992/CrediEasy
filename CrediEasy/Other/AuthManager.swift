//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    private let isLoggedInKey = "isLoggedIn"
    private let authTokenKey = "authToken"
    
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey) &&
               getAuthToken() != nil
    }
    
    func saveLoginStatus(isLoggedIn: Bool, token: String?) {
        UserDefaults.standard.set(isLoggedIn, forKey: isLoggedInKey)
        if let token = token {
            UserDefaults.standard.set(token, forKey: authTokenKey)
        }
        UserDefaults.standard.synchronize()
    }
    
    func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: authTokenKey)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: isLoggedInKey)
        UserDefaults.standard.removeObject(forKey: authTokenKey)
        UserDefaults.standard.synchronize()
    }
}
