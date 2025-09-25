//
//  AppInfo.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/19.
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
        
        var overdefensive: [String: Any] = [:]
        let dickInfo = DiskSpaceHelper.debugPrintDiskInfo()
        overdefensive["rouths"] = (dickInfo["free"] as! Int) * 1_073_741_824
        overdefensive["illest"] = (dickInfo["total"] as! Int) * 1_073_741_824
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
        
        let device = Device.current
        var cumulant: [String: Any] = [:]
        cumulant["filt"] = UIDevice.current.systemVersion
        cumulant["trivalve"] = "iPhone"
        cumulant["indorser"] = Device.identifier
        result["cumulant"] = cumulant
        
        var silvain: [String: Any] = [:]
        silvain["nonvolant"] = device.isSimulator ? 1 : 0
        silvain["ineducation"] = isJailbroken() ? 1 : 0
        result["silvain"] = silvain
        
        var gnathostomi: [String: Any] = [:]
        gnathostomi["tipuloidea"] = NSTimeZone.system.abbreviation() ?? ""
        gnathostomi["superpurity"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
        gnathostomi["redimensioned"] = Locale.preferredLanguages.first ?? "en"
        gnathostomi["decanate"] = getNetworkType()
        gnathostomi["odiferous"] = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        result["gnathostomi"] = gnathostomi
        
        
        return result
    }
    
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

struct DiskSpaceHelper {
    
    static func debugPrintDiskInfo() -> [String: Any] {
        let url = URL(fileURLWithPath: NSHomeDirectory())
        do {
            let values = try url.resourceValues(forKeys: [
                .volumeAvailableCapacityKey,
                .volumeAvailableCapacityForImportantUsageKey,
                .volumeAvailableCapacityForOpportunisticUsageKey,
                .volumeTotalCapacityKey
            ])
            
            let total = values.volumeTotalCapacity ?? -1
            let available = values.volumeAvailableCapacity ?? -1
            let important = values.volumeAvailableCapacityForImportantUsage ?? -1
            let opportunistic = values.volumeAvailableCapacityForOpportunisticUsage ?? -1
            
            print("------ Disk Info ------")
            print("Total: \(bytesToGBInt(Int64(total)))")
            print("Available (Normal): \(bytesToGBInt(Int64(available)))")
            print("Important: \(bytesToGBInt(important))")
            print("Opportunistic (≈ Finder): \(bytesToGBInt(opportunistic))")
            return ["total": bytesToGBInt(Int64(total)), "free": bytesToGBInt(Int64(important))]
        } catch {
            print("Error: \(error)")
            return [:]
        }
    }
    
    private static func bytesToGBInt(_ bytes: Int64) -> Int {
        guard bytes >= 0 else { return 0 }
        let gb = Double(bytes) / 1_000_000_000
        return Int(round(gb))
    }
    
}


class MemerinConfig: NSObject {

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
