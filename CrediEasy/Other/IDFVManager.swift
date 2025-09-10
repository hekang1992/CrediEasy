//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import KeychainAccess
import AppTrackingTransparency
import AdSupport

class IDFVManager {
    static let shared = IDFVManager()
    
    private let serviceIdentifier = "com.flytosky.apes"
    private let idfvKey = "deviceIDFV"
    
    private let keychain: Keychain
    
    private init() {
        keychain = Keychain(service: serviceIdentifier)
    }
    
    func getPersistentIDFV() -> String? {
        if let storedIDFV = try? keychain.getString(idfvKey), !storedIDFV.isEmpty {
            return storedIDFV
        }
        
        guard let newIDFV = getCurrentIDFV() else {
            return nil
        }
        
        do {
            try keychain.set(newIDFV, key: idfvKey)
            return newIDFV
        } catch {
            print("Failed to save IDFV to keychain: \(error)")
            return newIDFV
        }
    }
    
    private func getCurrentIDFV() -> String? {
        guard let identifier = UIDevice.current.identifierForVendor else {
            return nil
        }
        return identifier.uuidString
    }
    
}

class IDFAManager {
    
    static func requestIDFA(completion: @escaping (String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            if #available(iOS 14, *) {
                let status = ATTrackingManager.trackingAuthorizationStatus
                if status == .authorized {
                    completion(self.getIDFA())
                } else if status == .notDetermined {
                    ATTrackingManager.requestTrackingAuthorization { newStatus in
                        DispatchQueue.main.async {
                            if newStatus == .authorized {
                                completion(self.getIDFA())
                            } else {
                                completion(nil)
                            }
                        }
                    }
                } else {
                    completion(nil)
                }
            } else {
                if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                    completion(self.getIDFA())
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    static func getIDFA() -> String? {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}
