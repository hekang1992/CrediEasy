//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/10.
//

import Foundation
import CoreLocation

struct LocationInfo {
    let latitude: Double
    let longitude: Double
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
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var completion: ((LocationInfo?) -> Void)?
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
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
            completion(nil)
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        @unknown default:
            completion(nil)
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
            completion?(nil)
            completion = nil
        }
    }
}
