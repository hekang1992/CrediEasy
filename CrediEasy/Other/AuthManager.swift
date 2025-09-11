//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import Foundation

let schemeUrl = "io://at.eri.fo"
let homeSchemeUrl = "io://at.eri.fo/leerish"
let loginSchemeUrl = "io://at.eri.fo/demiman"
let setttingSchemeUrl = "io://at.eri.fo/Canossa"

class AuthManager {
    static let shared = AuthManager()
    private let phoneKey = "phoneNumber"
    private let tokenKey = "authToken"
    
    var isLoggedIn: Bool {
        guard let phone = UserDefaults.standard.string(forKey: phoneKey),
              let token = getAuthToken(),
              !phone.isEmpty,
              !token.isEmpty else {
            return false
        }
        return true
    }
    
    func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func saveLoginInfo(phone: String, token: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func removeLoginInfo() {
        UserDefaults.standard.removeObject(forKey: phoneKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
