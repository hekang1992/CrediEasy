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
import NetworkExtension

class DeviceInfoProvider {
    
    static func getDeviceInfoJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        
        // 存储
        var overdefensive: [String: Any] = [:]
        overdefensive["rouths"] = MemerinConfig.getFreeString()
        overdefensive["illest"] = MemerinConfig.getTotalString()
        overdefensive["deboistly"] = MemerinConfig.getTotalMemoryString()
        overdefensive["nonelaborative"] = MemerinConfig.getAvailableMemoryString()
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
    static func getWiFiDetails(completion: @escaping ([String: String]) -> Void) {
        NEHotspotNetwork.fetchCurrent { network in
            if let network = network {
                let details = [
                    "ssid": network.ssid,
                    "bssid": network.bssid
                ]
                completion(details)
            } else {
                completion(["ssid": "", "bssid": ""])
            }
        }
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

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    func startListening(completion: @escaping ((String) -> Void)) {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("notReachable===========")
                completion("notReachable")
            case .reachable(.ethernetOrWiFi):
                print("WIFI==============")
                completion("WIFI")
            case .reachable(.cellular):
                print("5G==============")
                completion("5G")
            case .unknown:
                print("unknown=========")
                completion("unknown")
            }
        })
    }
    
    func stopListening() {
        reachabilityManager?.stopListening()
    }
}

class MemerinConfig: NSObject {
    
    static func getFreeString() -> String {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory())
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            if let available = values.volumeAvailableCapacityForImportantUsage {
                return String(available + 5 * 1024 * 1024 * 1024)
            }
        } catch {
            print("Error disk space: \(error)")
        }
        return "0"
    }
    
    static func getTotalString() -> String {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory())
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey])
            if let total = values.volumeTotalCapacity {
                return String(total + 5 * 1024 * 1024 * 1024)
            }
        } catch {
            print("Error disk space: \(error)")
        }
        return "0"
    }
    
    static func getTotalMemoryString() -> String {
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        return String(totalMemory)
    }
    
    static func getAvailableMemoryString() -> String {
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
        
        let hostPort = mach_host_self()
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &count)
            }
        }
        
        if result != KERN_SUCCESS {
            return "0"
        }
        
        let pageSize = vm_kernel_page_size
        let freeMemory = UInt64(stats.free_count + stats.inactive_count) * UInt64(pageSize)
        
        return String(freeMemory)
    }
    
    
}
