//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import Foundation
import Lottie
import Toast_Swift

class LoadingView: UIView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return bgView
    }()
    
    lazy var hudView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading.json", bundle: Bundle.main)
        animationView.play()
        animationView.loopMode = .loop
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(bgView)
        bgView.addSubview(hudView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hudView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 124, height: 124))
        }
    }
    
}

class ViewHud {
    
    static let loadView = LoadingView()
    
    static func addLoadView() {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                DispatchQueue.main.async {
                    loadView.frame = keyWindow.bounds
                    keyWindow.addSubview(loadView)
                }
            }
        }
    }
    
    static func hideLoadView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            loadView.removeFromSuperview()
        }
    }
    
}


class ToastShowMessage {
    static func showToast(message: String) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                keyWindow.makeToast(message, duration: 2.0, position: .center)
            }
        }
    }
}
