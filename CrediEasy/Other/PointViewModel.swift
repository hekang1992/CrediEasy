//
//  PointViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/18.
//

import UIKit
import Combine

class PointViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    private let locationManager: LocationManager
    
    init(locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
    }
    
    func getMonesesInfo(with nonsuffrage: String,
                        pergamos: String,
                        paludicoline: String,
                        milkiness: String? = "") {
        locationManager.requestLocation { model in
            LocationInfoModel.shared.model = model
            print("进入了买点:=============\(nonsuffrage)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                print("✅ after 2s still alive")
                let locationModel = LocationInfoModel.shared.model
                let pharmaceutist = IDFVManager.shared.getPersistentIDFV() ?? ""
                let lacie = IDFAManager.getIDFA() ?? ""
                let homostylism = String(format: "%.6f", locationModel?.longitude ?? 0.0)
                let squeegeing = String(format: "%.6f", locationModel?.latitude ?? 0.0)
                let dict = ["ainsley": "2",
                            "pergamos": pergamos,
                            "paludicoline": paludicoline,
                            "nonsuffrage": nonsuffrage,
                            "pharmaceutist": pharmaceutist,
                            "lacie": lacie,
                            "homostylism": homostylism,
                            "squeegeing": squeegeing,
                            "milkiness": milkiness ?? ""]
                NetworkManager.shared.postForm(path: "/Sharpsburg/moneses", parameters: dict).sink { completion in
                    
                } receiveValue: { model in
                    
                }.store(in: &self.cancellables)
                    
                
            }
        }

    }
    
    
}
