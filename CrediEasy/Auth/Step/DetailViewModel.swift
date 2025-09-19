//
//  DetailViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import RxRelay
import Combine

final class DetailViewModel {
    
    static let shared = DetailViewModel()
    
    /// 产品详情模型---不是点击底部的
    var detailModel = BehaviorRelay<BaseModel?>(value: nil)
    
    /// 产品详情模型---是点击底部的--apply的
    var detailApplyModel = BehaviorRelay<BaseModel?>(value: nil)
    
    var listModelArray = BehaviorRelay<[beakfulModel]?>(value: nil)
    
//    var idModel = BehaviorRelay<BaseModel?>(value: nil)
    
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
                if isTap == true {
                    self.detailApplyModel.accept(model)
                }else {
                    self.detailApplyModel.accept(nil)
                }
                self.listModelArray.accept(model.ande?.beakful ?? [])
            }else {
                self.detailModel.accept(nil)
                self.detailApplyModel.accept(nil)
                self.listModelArray.accept(nil)
                ToastShowMessage.showToast(message: model.hypsodonty ?? "")
            }
        }.store(in: &cancellables)
    }
    
    /// 获取身份信息
    func getIDetaiInfo(productID: String, completion: @escaping ((BaseModel)) -> Void) {
        ViewHud.addLoadView()
        let dict = ["fuckups": productID]
        NetworkManager.shared.postForm(path: "/Sharpsburg/percents", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                completion(model)
            }
        }.store(in: &cancellables)
    }
    
    
    func getOrderInfo(to dict: [String: Any], completion: @escaping ((BaseModel) -> Void)) {
        ViewHud.addLoadView()
        NetworkManager.shared.postForm(path: "/Sharpsburg/overreligiousness", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            completion(model)
        }.store(in: &cancellables)

    }
    
}
