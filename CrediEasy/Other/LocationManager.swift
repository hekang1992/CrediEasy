//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/10.
//

import UIKit
import Foundation
import CoreLocation

struct LocationInfo {
    let latitude: Double?
    let longitude: Double?
    let countryCode: String?
    let country: String?
    let administrativeArea: String?
    let subAdministrativeArea: String?
    let locality: String?
    let subLocality: String?
    let thoroughfare: String?
    let subThoroughfare: String?
}

class LocationManager: NSObject {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var completion: ((LocationInfo?) -> Void)?
    
    /// UserDefaults 的 key
    private let lastDeniedAlertDateKey = "LastDeniedAlertDate"
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    deinit {
        // 清理资源
        completion = nil
    }
    
    func requestLocation(completion: @escaping (LocationInfo?) -> Void) {
        self.completion = completion
        
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = manager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showDeniedAlertIfNeeded()
            completion(nil)
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        @unknown default:
            completion(nil)
        }
    }
    
    /// 停止位置更新
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
        completion = nil
    }
    
    /// 检查是否可以显示拒绝定位弹窗（一天只显示一次）
    private func canShowDeniedAlert() -> Bool {
        guard let lastAlertDate = UserDefaults.standard.object(forKey: lastDeniedAlertDateKey) as? Date else {
            // 如果没有记录，说明可以显示
            return true
        }
        
        // 检查是否已经过了一天
        let currentDate = Date()
        let calendar = Calendar.current
        
        // 方法1：检查是否在同一天（更严格）
        // return !calendar.isDate(currentDate, inSameDayAs: lastAlertDate)
        
        // 方法2：检查是否已经过了24小时（更灵活）
        let timeInterval = currentDate.timeIntervalSince(lastAlertDate)
        let hours24: TimeInterval = 24 * 60 * 60
        return timeInterval >= hours24
    }
    
    /// 记录弹窗显示时间
    private func recordDeniedAlertDate() {
        UserDefaults.standard.set(Date(), forKey: lastDeniedAlertDateKey)
        UserDefaults.standard.synchronize()
    }
    
    private func showDeniedAlertIfNeeded() {
        // 检查是否可以显示弹窗
        guard canShowDeniedAlert() else { return }
        
        // 记录本次弹窗时间
        recordDeniedAlertDate()
        
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootVC = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                return
            }
            
            let alert = UIAlertController(
                title: "Location permission",
                message: "You've disabled location permission. To restore full functionality, go to Settings > Privacy > Location Services, select our app, and enable location access.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }))
            
            rootVC.present(alert, animated: true)
        }
    }
    
    /// 重置弹窗记录（用于测试或特殊情况）
    func resetDeniedAlertRecord() {
        UserDefaults.standard.removeObject(forKey: lastDeniedAlertDateKey)
        UserDefaults.standard.synchronize()
    }
    
    /// 获取最后一次弹窗日期（用于调试）
    func getLastDeniedAlertDate() -> Date? {
        return UserDefaults.standard.object(forKey: lastDeniedAlertDateKey) as? Date
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else {
            completion?(nil)
            completion = nil
            return
        }
        
        geocoder.reverseGeocodeLocation(loc) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let placemark = placemarks?.first, error == nil {
                let info = LocationInfo(
                    latitude: loc.coordinate.latitude,
                    longitude: loc.coordinate.longitude,
                    countryCode: placemark.isoCountryCode,
                    country: placemark.country,
                    administrativeArea: placemark.administrativeArea,
                    subAdministrativeArea: placemark.subAdministrativeArea,
                    locality: placemark.locality,
                    subLocality: placemark.subLocality,
                    thoroughfare: placemark.thoroughfare,
                    subThoroughfare: placemark.subThoroughfare
                )
                self.completion?(info)
            } else {
                self.completion?(nil)
            }
            self.completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil)
        completion = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = manager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.requestLocation()
        } else if status == .denied || status == .restricted {
            showDeniedAlertIfNeeded()
            completion?(nil)
            completion = nil
        }
    }
}
