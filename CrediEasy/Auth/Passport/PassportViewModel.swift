//
//  PassportViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import RxRelay
import Combine


final class PassportViewModel {
    
    var detailModel = BehaviorRelay<BaseModel?>(value: nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    /// 获取产品详情信息
    func getProductDetaiInfo(productID: String,
                             isTap: Bool? = false) {
        ViewHud.addLoadView()
        let dict = ["fuckups": productID]
        NetworkManager.shared.postForm(path: "/Sharpsburg/anderssen", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.detailModel.accept(model)
            }
        }.store(in: &cancellables)
    }
    
}
