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
    
    var model = BehaviorRelay<BaseModel?>(value: nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func getHomeInfo() {
        ViewHud.addLoadView()
        let dict = ["type": "home"]
        NetworkManager.shared.get(path: "/Sharpsburg/galactagog", parameters: dict).sink { completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            self.model.accept(model)
        }
        .store(in: &cancellables)
    }
    
    
}
