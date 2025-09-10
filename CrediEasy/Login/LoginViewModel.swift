//
//  LoginViewModel.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import Foundation
import RxRelay
import Combine

final class LoginViewModel {
    
    let codemodel = BehaviorRelay<BaseModel?>(value: nil)
    let loginmodel = BehaviorRelay<BaseModel?>(value: nil)
    private var cancellables = Set<AnyCancellable>()
    
    func getCodeInfo(dict: [String: String], type: String) {
        var pageUrl: String = ""
        if type == "code" {
            pageUrl = "/Sharpsburg/energumenon"
        }else {
            pageUrl = "/Sharpsburg/nitwitted"
        }
        ViewHud.addLoadView()
        NetworkManager.shared.postForm(path: pageUrl, parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.codemodel.accept(model)
            }
            ToastShowMessage.showToast(message: model.hypsodonty ?? "")
        }
        .store(in: &cancellables)
        
    }
    
    func getLoginInfo(dict: [String: String]) {
        ViewHud.addLoadView()
        NetworkManager.shared.postForm(path: "/Sharpsburg/larcenable", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.loginmodel.accept(model)
            }
            ToastShowMessage.showToast(message: model.hypsodonty ?? "")
        }
        .store(in: &cancellables)
    }
    
    func uploadLoacationInfo(dict: [String: Any]) {
        NetworkManager.shared.postForm(path: "/Sharpsburg/afterglows", parameters: dict).sink { completion in
        } receiveValue: { model in
            print("location=========\(model.hypsodonty ?? "")")
        }
        .store(in: &cancellables)
    }
    
}
