//
//  CenterViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/10.
//

import RxSwift
import RxRelay
import Combine

final class CenterViewModel {
    
    let model = BehaviorRelay<BaseModel?>(value: nil)
    private var cancellables = Set<AnyCancellable>()
    
    func getCenterInfo() {
        ViewHud.addLoadView()
        NetworkManager.shared.get(path: "/Sharpsburg/sauch").sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.model.accept(model)
            }
        }
        .store(in: &cancellables)
        
    }
    
    
}
