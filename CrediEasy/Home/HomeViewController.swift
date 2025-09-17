//
//  HomeViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import MJRefresh

class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel()
    
    var disgaveledModelArray: [disgaveledModel] = []
    
    lazy var homeView: HomeView = {
        let homeView = HomeView()
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
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
        
        viewModel.model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.homeView.scrollView.mj_header?.endRefreshing()
            if model.larcenable == "0" || model.larcenable == "00" {
                for model in model.ande?.buoyed ?? [] {
                    if model.derailer == "discinoid" {
                        self.disgaveledModelArray = model.disgaveled ?? []
                        let disgaveledModelArray = model.disgaveled ?? []
                        if let model = disgaveledModelArray.first {
                            homeView.desclabel.text = model.arrode ?? ""
                            homeView.moneylabel.text = model.photoelectron ?? ""
                            homeView.oneView.desclabel.text = model.fleuret ?? ""
                            homeView.twoView.desclabel.text = model.unresourcefulness ?? ""
                            homeView.applyBtn.setTitle(model.consuelo ?? "", for: .normal)
                            homeView.appLogoImageView.kf.setImage(with: URL(string: model.crackrope ?? ""))
                            homeView.appNamelabel.text = model.threeDes ?? ""
                        }
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
    }
    
}
