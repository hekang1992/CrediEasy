//
//  AppStepViewViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit

class AppStepViewViewController: BaseViewController {
    
    var productID: String = ""
    
    let viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#0073E5")
        
        view.addSubview(headView)
        headView.namelabel.text = "Authentication steps"
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.viewModel.getProductDetaiInfo(productID: self.productID)
        }
        
    }
    
}

extension AppStepViewViewController {
    
}
