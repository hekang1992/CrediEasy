//
//  ProfileViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let viewModel = CenterViewModel()
    
    lazy var centerView: CenterView = {
        let centerView = CenterView(frame: .zero)
        return centerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewModel.model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            centerView.phoneLabel.text = model.ande?.userInfo?.userphone ?? ""
            centerView.modelArray = model.ande?.buoyed ?? []
            centerView.tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCenterInfo()
    }
    
}
