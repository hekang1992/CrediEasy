//
//  SettingViewController.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/12.
//

import UIKit
import TYAlertController
import Combine
import RxSwift

class SettingViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var model: BaseModel? {
        didSet {
            guard let model = model, let toothful = model.ande?.toothful?.first else { return }
            let priInfo = toothful.skyhook ?? ""
            let loanInfo = toothful.circumduct ?? ""
            twoListView.isHidden = priInfo.isEmpty
            threeListView.isHidden = loanInfo.isEmpty
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "center_head_image")
        return headImageView
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.textColor = UIColor.init(hexString: "#FFFFFF")
        desclabel.textAlignment = .left
        desclabel.text = "Current app version"
        desclabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return desclabel
    }()
    
    lazy var versionlabel: UILabel = {
        let versionlabel = UILabel()
        versionlabel.textColor = UIColor.init(hexString: "#FFFFFF")
        versionlabel.textAlignment = .left
        versionlabel.text = "v1.0.0"
        versionlabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(700))
        return versionlabel
    }()
    
    lazy var oneListView: CenterListView = {
        let oneListView = CenterListView()
        oneListView.letImageView.image = UIImage(named: "cenlist_two_image")
        oneListView.namelabel.text = "Delete Account"
        return oneListView
    }()
    
    lazy var twoListView: CenterListView = {
        let twoListView = CenterListView()
        twoListView.letImageView.image = UIImage(named: "cenlist_one_image")
        twoListView.namelabel.text = "Privacy Policy"
        return twoListView
    }()
    
    lazy var threeListView: CenterListView = {
        let threeListView = CenterListView()
        threeListView.letImageView.image = UIImage(named: "cenlist_three_image")
        threeListView.namelabel.text = "Loan Agreement"
        return threeListView
    }()
    
    lazy var loginOutBtn: UIButton = {
        let loginOutBtn = UIButton(type: .custom)
        loginOutBtn.setTitle("Log Out", for: .normal)
        loginOutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        loginOutBtn.setTitleColor(.white, for: .normal)
        loginOutBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        loginOutBtn.layer.cornerRadius = 27
        loginOutBtn.layer.masksToBounds = true
        return loginOutBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#EAF5FF")
        
        view.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(184)
        }
        
        view.addSubview(headView)
        headView.namelabel.text = "Setting"
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        headImageView.addSubview(versionlabel)
        headImageView.addSubview(desclabel)
        
        versionlabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(24)
        }
        desclabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(versionlabel.snp.top).offset(-5)
            make.height.equalTo(17)
        }
        
        view.addSubview(oneListView)
        view.addSubview(twoListView)
        view.addSubview(threeListView)
        
        oneListView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(60)
        }
        twoListView.snp.makeConstraints { make in
            make.top.equalTo(oneListView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(60)
        }
        threeListView.snp.makeConstraints { make in
            make.top.equalTo(twoListView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(60)
        }
        
        view.addSubview(loginOutBtn)
        loginOutBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(54)
            make.top.equalTo(threeListView.snp.bottom).offset(40)
        }
        
        oneListView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let deleteView = DeleteView(frame: self.view.frame)
            if let alertVc = TYAlertController(alert: deleteView, preferredStyle: .alert) {
                self.present(alertVc, animated: true)
            }
            deleteView.agreeBtn.rx.tap.subscribe(onNext: { [weak self] in
                deleteView.agreeBtn.isSelected.toggle()
            }).disposed(by: disposeBag)
            
            deleteView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if deleteView.agreeBtn.isSelected {
                    self.dismiss(animated: true) {
                        self.deleteAppInfo()
                    }
                }else {
                    ToastShowMessage.showToast(message: "Please read and agree to the above content")
                }
            }).disposed(by: disposeBag)
            
            deleteView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
        
        twoListView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let webVc = ChangeCidViewController()
            webVc.pageUrl = model?.ande?.toothful?.first?.skyhook ?? ""
            self.navigationController?.pushViewController(webVc, animated: true)
        }).disposed(by: disposeBag)
        
        threeListView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let webVc = ChangeCidViewController()
            webVc.pageUrl = model?.ande?.toothful?.first?.circumduct ?? ""
            self.navigationController?.pushViewController(webVc, animated: true)
        }).disposed(by: disposeBag)
        
        loginOutBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let logoutView = LogOutView(frame: self.view.frame)
            if let alertVc = TYAlertController(alert: logoutView, preferredStyle: .alert) {
                self.present(alertVc, animated: true)
            }
            logoutView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true) {
                    self?.logoutInfo()
                }
            }).disposed(by: disposeBag)
            
            logoutView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
        
        
    }
    
}

extension SettingViewController {
    
    private func logoutInfo() {
        ViewHud.addLoadView()
        NetworkManager.shared.get(path: "/Sharpsburg/blam").sink { Completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                AuthManager.shared.removeLoginInfo()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
                }
            }
        }
        .store(in: &cancellables)
    }
    
    private func deleteAppInfo() {
        ViewHud.addLoadView()
        NetworkManager.shared.get(path: "/Sharpsburg/unminimized").sink { Completion in
            ViewHud.hideLoadView()
        } receiveValue: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                AuthManager.shared.removeLoginInfo()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
                }
            }
        }
        .store(in: &cancellables)
    }
    
}
