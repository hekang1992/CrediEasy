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
    
    var idModel = BehaviorRelay<BaseModel?>(value: nil)
    
    var popPhotoModel = BehaviorRelay<BaseModel?>(value: nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    /// 获取产品详情信息
    func getProductDetaiInfo(productID: String,
                             isTap: Bool? = false) {
        let dict = ["fuckups": productID]
        ViewHud.addLoadView()
        NetworkManager.shared.postForm(path: "/Sharpsburg/anderssen", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.detailModel.accept(model)
            }
        }.store(in: &cancellables)
    }
    
    /// 获取身份信息
    func getIDetaiInfo(productID: String) {
        ViewHud.addLoadView()
        let dict = ["fuckups": productID]
        NetworkManager.shared.postForm(path: "/Sharpsburg/percents", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.idModel.accept(model)
            }
        }.store(in: &cancellables)
    }
    
    func upLoadPhotoImage(with dict: [String: Any], image: UIImage) {
        ViewHud.addLoadView()
        NetworkManager.shared.uploadImage(path: "/Sharpsburg/hematopoietically",
                                          parameters: dict,
                                          image: image).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.popPhotoModel.accept(model)
            }
            ToastShowMessage.showToast(message: model.hypsodonty ?? "")
        }.store(in: &cancellables)

    }
    
    func safePhotoInfo(with dict: [String: String], completion: @escaping ((BaseModel)) -> Void) {
        ViewHud.addLoadView()
        NetworkManager.shared.postForm(path: "/Sharpsburg/fifteenths", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            completion(model)
        }.store(in: &cancellables)

    }
    
    
    func upLoadFaceImage(with dict: [String: Any], image: UIImage, completion: @escaping ((BaseModel)) -> Void) {
        ViewHud.addLoadView()
        NetworkManager.shared.uploadImage(path: "/Sharpsburg/hematopoietically",
                                          parameters: dict,
                                          image: image).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            completion(model)
        }.store(in: &cancellables)

    }
    
}
