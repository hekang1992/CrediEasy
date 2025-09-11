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
        
        viewModel.model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.homeView.scrollView.mj_header?.endRefreshing()
            if model.larcenable == "0" || model.larcenable == "00" {
                
            }
        }).disposed(by: disposeBag)
        
        
        homeView.agreeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            homeView.agreeBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        
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
