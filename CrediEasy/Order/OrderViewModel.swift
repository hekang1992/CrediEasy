//
//  OrderViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import Combine
import RxRelay

final class OrderViewModel {
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    func getOrderListInfo(type: String) {
        ViewHud.addLoadView()
        let dict = ["cabinlike": type]
        NetworkManager.shared.postForm(path: "/Sharpsburg/dynah", parameters: dict).sink { Completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.model.accept(model)
            }
        }
        .store(in: &cancellables)

    }
    
}
