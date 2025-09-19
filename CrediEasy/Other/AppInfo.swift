//
//  AppInfo.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/19.
//

import UIKit
import Foundation
import AdSupport
import SystemConfiguration.CaptiveNetwork
import DeviceKit
import Alamofire

class DeviceInfoProvider {
    
    static func getDeviceInfoJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        
        // 存储
        var overdefensive: [String: Any] = [:]
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let freeSize = attrs[.systemFreeSize] as? NSNumber,
               let totalSize = attrs[.systemSize] as? NSNumber {
                overdefensive["rouths"] = "\(freeSize.int64Value)"
                overdefensive["illest"] = "\(totalSize.int64Value)"
            }
        }
        overdefensive["deboistly"] = "\(ProcessInfo.processInfo.physicalMemory)"
        overdefensive["nonelaborative"] = "\(getAvailableMemory() ?? 0)"
        result["overdefensive"] = overdefensive
        
        // 电池
        UIDevice.current.isBatteryMonitoringEnabled = true
        var leucochalcite: [String: Any] = [:]
        let level = UIDevice.current.batteryLevel
        if level >= 0 {
            leucochalcite["jingoed"] = Int(level * 100)
        }
        let state = UIDevice.current.batteryState
        leucochalcite["incolumity"] = (state == .charging || state == .full) ? 1 : 0
        result["leucochalcite"] = leucochalcite
        
        // 系统 / 型号
        let device = Device.current
        var cumulant: [String: Any] = [:]
        cumulant["filt"] = UIDevice.current.systemVersion
        cumulant["trivalve"] = "iPhone"
        cumulant["indorser"] = Device.identifier // 例如 "iPhone10,3"
        result["cumulant"] = cumulant
        
        // 模拟器 / 越狱
        var silvain: [String: Any] = [:]
        silvain["nonvolant"] = device.isSimulator ? 1 : 0
        silvain["ineducation"] = isJailbroken() ? 1 : 0
        result["silvain"] = silvain
        
        // 其他信息
        var gnathostomi: [String: Any] = [:]
        gnathostomi["tipuloidea"] = NSTimeZone.system.abbreviation() ?? ""
        gnathostomi["superpurity"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
        gnathostomi["redimensioned"] = Locale.preferredLanguages.first ?? "en"
        gnathostomi["decanate"] = getNetworkType()
        gnathostomi["odiferous"] = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        result["gnathostomi"] = gnathostomi
        
        // WiFi
        var avitaminotic: [String: Any] = [:]
        avitaminotic["pamperedly"] = [
            "butyrometric": getBSSID(),
            "banshees": getSSID()
        ]
        result["avitaminotic"] = avitaminotic
        
        return result
    }
    
    // MARK: - 可用内存
    private static func getAvailableMemory() -> UInt64? {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_,
                          task_flavor_t(MACH_TASK_BASIC_INFO),
                          $0,
                          &count)
            }
        }
        return (kerr == KERN_SUCCESS) ? UInt64(info.resident_size) : nil
    }
    
    // MARK: - 越狱检测
    private static func isJailbroken() -> Bool {
        let paths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    private static func getNetworkType() -> String {
        return NetworkUtils.getNetworkType()
    }
    
    // MARK: - WiFi 信息
    static func getBSSID() -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        
        for interface in interfaces {
            guard let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] else {
                continue
            }
            
            if let bssid = interfaceInfo["BSSID"] as? String {
                return bssid
            }
        }
        return ""
    }
    
    static func getSSID() -> String? {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            currentSSID = myDict["SSID"] as? String ?? ""
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
}

class NetworkUtils {
    static let reachabilityManager = NetworkReachabilityManager()

    static func getNetworkType() -> String {
        guard let manager = reachabilityManager else {
            return "UNKNOWN"
        }

        if manager.isReachable {
            if manager.isReachableOnEthernetOrWiFi {
                return "WIFI"
            } else if manager.isReachableOnCellular {
                return "5G"
            }
        }
        return "NO CONNECTION"
    }
}
