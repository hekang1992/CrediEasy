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
    
    /// 标记是否已经弹出过"拒绝定位"的提示
    private var hasShownDeniedAlert = false
    
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
    
    private func showDeniedAlertIfNeeded() {
        guard !hasShownDeniedAlert else { return }
        hasShownDeniedAlert = true
        
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
