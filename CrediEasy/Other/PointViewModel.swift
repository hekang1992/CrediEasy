//
//  PointViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/18.
//

import Combine

final class PointViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getMonesesInfo(with nonsuffrage: String,
                        pergamos: String,
                        paludicoline: String,
                        milkiness: String? = "") {
        LocationManager.shared.requestLocation { [self] model in
            let pharmaceutist = IDFVManager.shared.getPersistentIDFV() ?? ""
            let lacie = IDFAManager.getIDFA() ?? ""
            let homostylism = String(format: "%.6f", model?.longitude ?? 0.0)
            let squeegeing = String(format: "%.6f", model?.latitude ?? 0.0)
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
                
            }.store(in: &cancellables)

        }

    }
    
    
}
