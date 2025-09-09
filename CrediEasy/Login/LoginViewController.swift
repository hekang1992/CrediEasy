//
//  LoginViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import RxGesture

class LoginViewController: BaseViewController {
    
    private var countdownTimer: Timer?
    private var remainingSeconds: Int = 60
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.sendBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            startTime()
            ViewHud.addLoadView()
        }).disposed(by: disposeBag)
        
        
    }
    
    deinit {
        countdownTimer?.invalidate()
    }
    
}

extension LoginViewController {
    
    func startTime() {
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateCountdown),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func updateCountdown() {
        remainingSeconds -= 1
        updateButtonTitle()
        
        if remainingSeconds <= 0 {
            stopCountdown()
        }
    }
    
    private func updateButtonTitle() {
        if remainingSeconds > 0 {
            loginView.sendBtn.isEnabled = false
            loginView.sendBtn.setTitle("\(remainingSeconds)s", for: .normal)
        } else {
            loginView.sendBtn.isEnabled = true
            loginView.sendBtn.setTitle("Send", for: .normal)
        }
    }
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        
        loginView.sendBtn.isEnabled = true
        loginView.sendBtn.backgroundColor = .systemBlue
        remainingSeconds = 60
        ViewHud.hideLoadView()
    }
    
}
