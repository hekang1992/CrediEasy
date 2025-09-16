//
//  PersonalViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/16.
//

import RxRelay
import Combine

final class PersonalViewModel {
    
    var detailModel = BehaviorRelay<BaseModel?>(value: nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    /// 获取产品详情信息
    func getProductDetaiInfo(productID: String,
                             isTap: Bool? = false) {
        let dict = ["fuckups": productID]
        NetworkManager.shared.postForm(path: "/Sharpsburg/anderssen", parameters: dict).sink { completion in
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.detailModel.accept(model)
            }
        }.store(in: &cancellables)
    }
    
    /// 个人信息
    func getPersonalInfo(with productID: String, completion: @escaping (BaseModel) -> Void) {
        ViewHud.addLoadView()
        let dict = ["fuckups": productID]
        NetworkManager.shared.postForm(path: "/Sharpsburg/unknits", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            completion(model)
        }.store(in: &cancellables)

    }
}
