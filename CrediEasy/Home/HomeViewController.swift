//
//  HomeViewController.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/9.
//

import UIKit
import MJRefresh
import RxSwift
import Combine

class HomeViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = HomeViewModel()
    
    var disgaveledModelArray: [disgaveledModel] = []
    
    let loginViewModel = LoginViewModel()
    
    let locationManager = LocationManager()
    
    lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.isHidden = true
        return homeView
    }()
    
    lazy var hotView: FrontView = {
        let hotView = FrontView()
        hotView.isHidden = true
        return hotView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(homeView)
        view.addSubview(hotView)
        view.backgroundColor = UIColor.white
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hotView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeInfo()
        })
        self.hotView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeInfo()
        })
        
        self.homeView.applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.homeView.agreeBtn.isSelected {
                if let productID = self.disgaveledModelArray.first?.amps {
                    viewModel.applyProductInfo(productID: productID)
                }
            }else {
                ToastShowMessage.showToast(message: "Kindly review and accept our loan items prior to proceeding.")
            }
        }).disposed(by: disposeBag)
        
        self.homeView.applyImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] gesture in
            guard let self = self else { return }
            let model = viewModel.model.value
            let pageUrl = model?.ande?.melena?.unminimized ?? ""
            let location = gesture.location(in: self.homeView.applyImageView)
            if self.homeView.agreementLabel.frame.contains(location) {
                let webVc = ChangeCidViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
                return
            }
            if pageUrl.isEmpty {
                if let productID = self.disgaveledModelArray.first?.amps {
                    viewModel.applyProductInfo(productID: productID)
                }
            }else {
                if self.homeView.agreeBtn.isSelected {
                    if let productID = self.disgaveledModelArray.first?.amps {
                        viewModel.applyProductInfo(productID: productID)
                    }
                } else {
                    ToastShowMessage.showToast(message: "Kindly review and accept our loan items prior to proceeding.")
                }
            }
        }).disposed(by: disposeBag)
        
        self.hotView.headBlock = { [weak self] productID in
            guard let self = self else { return }
            viewModel.applyProductInfo(productID: productID)
        }
        
        viewModel.model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model1 = model else { return }
            self.homeView.scrollView.mj_header?.endRefreshing()
            self.hotView.scrollView.mj_header?.endRefreshing()
            if model1.larcenable == "0" || model1.larcenable == "00" {
                let unminimized = model1.ande?.melena?.unminimized ?? ""
                if unminimized.isEmpty {
                    self.homeView.agreeBtn.isHidden = true
                    self.homeView.agreementLabel.isHidden = true
                }else {
                    self.homeView.agreeBtn.isHidden = false
                    self.homeView.agreementLabel.isHidden = false
                }
                for model in model1.ande?.buoyed ?? [] {
                    if model.derailer == "discinoid" { /// 1
                        homeView.isHidden = false
                        hotView.isHidden = true
                        self.disgaveledModelArray = model.disgaveled ?? []
                        let disgaveledModelArray = model.disgaveled ?? []
                        if let model = disgaveledModelArray.first {
                            homeView.desclabel.text = model.arrode ?? ""
                            homeView.moneylabel.text = model.photoelectron ?? ""
                            homeView.oneView.desclabel.text = model.fleuret ?? ""
                            homeView.twoView.desclabel.text = model.unresourcefulness ?? ""
                            homeView.applyBtn.setTitle(model.consuelo ?? "", for: .normal)
                            homeView.appLogoImageView.kf.setImage(with: URL(string: model.crackrope ?? ""))
                            homeView.appNamelabel.text = model.saxcornet ?? ""
                        }
                    }else if model.derailer == "Daneflower" { /// 2
                        homeView.isHidden = true
                        hotView.isHidden = false
                        hotView.model = model1
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        
        homeView.agreeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            homeView.agreeBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        
        viewModel.applyModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            let roguy = model.ande?.roguy ?? ""
            if roguy.contains(detailSchemeUrl) {
                let dict = URLParameterParser.getQueryParameters(from: roguy)
                let stepVc = AppStepViewViewController()
                stepVc.productID = dict["fuckups"] ?? ""
                self.navigationController?.pushViewController(stepVc, animated: true)
            }else {
                let pageUrl = model.ande?.roguy ?? ""
                let webVc = ChangeCidViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }).disposed(by: disposeBag)
        
        viewModel.getCityAddressInfo()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
}

extension HomeViewController {
    
    private func getHomeInfo() {
        viewModel.getHomeInfo()
        
        locationManager.requestLocation { info in
            if let info = info {
                let dict = ["deflux": info.administrativeArea ?? "",
                            "smacksman": info.countryCode ?? "",
                            "girasol": info.country ?? "",
                            "anthorine": "\(info.thoroughfare ?? "") \(info.subThoroughfare ?? "")",
                            "squeegeing": String(format: "%.6f", info.latitude ?? 0.0),
                            "homostylism": String(format: "%.6f", info.longitude ?? 0.0),
                            "unspread": info.locality ?? "",
                            "fleche": info.subLocality ?? ""]
                self.loginViewModel.uploadLoacationInfo(dict: dict)
            } else {
                print("❌========")
            }
        }
    
        var dict = DeviceInfoProvider.getDeviceInfoJSON()
        /// WiFi
        var avitaminotic: [String: Any] = [:]
        DeviceInfoProvider.getWiFiDetails { [self] details in
            avitaminotic["pamperedly"] = [
                "butyrometric": details["bssid"] ?? "",
                "banshees": details["ssid"] ?? ""
            ]
            dict["avitaminotic"] = avitaminotic
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                viewModel.uploadAppinfo(to: jsonString)
            }
        }
        
        /// idfa
        viewModel.getRequestIDFA()
        
    }
    
}
