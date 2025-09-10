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
    
    let viewModel = LoginViewModel()
    
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
            let phoneNumber = self.loginView.phoneTx.text ?? ""
            if phoneNumber.isEmpty {
                ToastShowMessage.showToast(message: "Please Input Your Phone")
                return
            }
            let dict = ["anthemwise": phoneNumber, "app": "code"]
            viewModel.getCodeInfo(dict: dict, type: "code")
        }).disposed(by: disposeBag)
        
        loginView.voiceBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let phoneNumber = self.loginView.phoneTx.text ?? ""
            if phoneNumber.isEmpty {
                ToastShowMessage.showToast(message: "Please Input Your Phone")
                return
            }
            let dict = ["anthemwise": phoneNumber, "app": "voice"]
            viewModel.getCodeInfo(dict: dict, type: "voice")
        }).disposed(by: disposeBag)
        
        viewModel.codemodel.subscribe(onNext: { [weak self] model in
            if let self = self, let _ = model {
                startTime()
            }
        }).disposed(by: disposeBag)
        
        loginView.agreeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            loginView.agreeBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        
        loginView.loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.loginView.agreeBtn.isSelected {
                let phone = self.loginView.phoneTx.text ?? ""
                let code = self.loginView.codeTx.text ?? ""
                if phone.isEmpty {
                    ToastShowMessage.showToast(message: "Please Input Your Phone")
                    return
                }
                if code.isEmpty {
                    ToastShowMessage.showToast(message: "Please Input Your Code")
                    return
                }
                let dict = ["dioon": phone, "overreligiousness": code]
                viewModel.getLoginInfo(dict: dict)
            }else {
                ToastShowMessage.showToast(message: "Kindly review and accept our Privacy Policy prior to proceeding.")
            }
        }).disposed(by: disposeBag)
        
        viewModel.loginmodel.asObservable().subscribe(onNext: { model in
            guard let model = model else { return }
            let dioon = model.ande?.dioon ?? ""
            let hullabaloos = model.ande?.hullabaloos ?? ""
            AuthManager.shared.saveLoginInfo(phone: dioon, token: hullabaloos)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
            }
        }).disposed(by: disposeBag)
        
        
        LocationManager.shared.requestLocation { info in
            if let info = info {
                let dict = ["deflux": info.administrativeArea ?? "",
                            "smacksman": info.countryCode ?? "",
                            "girasol": info.country ?? "",
                            "anthorine": "\(info.thoroughfare ?? "") \(info.subThoroughfare ?? "")",
                            "squeegeing": info.latitude,
                            "homostylism": info.latitude,
                            "unspread": info.locality ?? "",
                            "fleche": info.subLocality ?? ""]
                self.viewModel.uploadLoacationInfo(dict: dict)
            } else {
                print("❌========")
            }
        }
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
    }
    
}

