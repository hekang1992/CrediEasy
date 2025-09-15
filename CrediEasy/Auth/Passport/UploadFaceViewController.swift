//
//  UploadFaceViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit

class UploadFaceViewController: BaseViewController {
    
    let viewModel = PassportViewModel()
    
    var type: String = ""
    var productID: String = ""
    
    lazy var whiteView: UIView = {
        let whiteView = UIView(frame: .zero)
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 25
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var stepView: StepView = {
        let stepView = StepView()
        return stepView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#0073E5")
        view.addSubview(headView)
        headView.namelabel.text = "ldentity Authentication"
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        view.addSubview(stepView)
        stepView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(19)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.bottom).offset(26)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(20)
        }
        
        viewModel.detailModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            stepView.modelArray = model.ande?.beakful ?? []
            stepView.setCurrentIndex(0, animated: false)
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getProductDetaiInfo(productID: productID)
    }
    
}

extension UploadFaceViewController {
    
}
