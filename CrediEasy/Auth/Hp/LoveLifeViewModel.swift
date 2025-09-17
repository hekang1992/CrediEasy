//
//  LoveLifeViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/17.
//

import RxRelay
import Combine

final class LoveLifeViewModel {
    
    
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
        NetworkManager.shared.postForm(path: "/Sharpsburg/commonalty", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            completion(model)
        }.store(in: &cancellables)
    }
    
    func safePersonalInfo(wit dict: [String: Any], completion: @escaping (BaseModel) -> Void) {
        ViewHud.addLoadView()
        NetworkManager.shared.postForm(path: "/Sharpsburg/moonblink", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            completion(model)
        }.store(in: &cancellables)

    }
    
    func pushMessageInfo(to dict: [String: String]) {
        NetworkManager.shared.postForm(path: "/Sharpsburg/preparer", parameters: dict).sink { completion in
            
        } receiveValue: { model in
            
        }.store(in: &cancellables)

    }
    
}
