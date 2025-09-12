//
//  SettingViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit
import TYAlertController

class SettingViewController: BaseViewController {
    
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
            let deleteView = DeleteView(frame: UIScreen.main.bounds)
            if let alertVc = TYAlertController(alert: deleteView, preferredStyle: .alert) {
                self.present(alertVc, animated: true)
            }
            deleteView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
                
            }).disposed(by: disposeBag)
            
            deleteView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
        
        loginOutBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let logoutView = LogOutView(frame: UIScreen.main.bounds)
            if let alertVc = TYAlertController(alert: logoutView, preferredStyle: .alert) {
                self.present(alertVc, animated: true)
            }
            logoutView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
                
            }).disposed(by: disposeBag)
            
            logoutView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
        
        
    }
    
}
