//
//  HomeViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/11.
//

import RxSwift
import RxRelay
import Combine

final class HomeViewModel {
    
    /// 首页数据模型
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    /// 申请模型
    var applyModel = BehaviorRelay<BaseModel?>(value: nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func getHomeInfo() {
        ViewHud.addLoadView()
        let dict = ["type": "home"]
        NetworkManager.shared.get(path: "/Sharpsburg/galactagog",
                                  parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            self.model.accept(model)
        }
        .store(in: &cancellables)
    }
    
    func getCityAddressInfo() {
        NetworkManager.shared.get(path: "/Sharpsburg/nordica").sink { completion in
            
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                CityInfoModel.shared.cityModel = model.ande
            }
        }.store(in: &cancellables)

    }
    
    func applyProductInfo(productID: Int) {
        ViewHud.addLoadView()
        let dict = ["fuckups": String(productID)]
        NetworkManager.shared.postForm(path: "/Sharpsburg/derned",
                                       parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.applyModel.accept(model)
            }else {
                ToastShowMessage.showToast(message: model.hypsodonty ?? "")
            }
        }.store(in: &cancellables)

    }
    
}
