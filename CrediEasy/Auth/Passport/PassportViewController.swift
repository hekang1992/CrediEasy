//
//  PassportViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit

class PassportViewController: BaseViewController {

    var productID: String = ""
    
    var model: BaseModel? {
        didSet {
            guard let model = model, let ande = model.ande else { return }
            passportView.model = ande
            passportView.oneTableView.reloadData()
            passportView.twoTableView.reloadData()
        }
    }
    
    lazy var passportView: PassportView = {
        let passportView = PassportView(frame: .zero)
        return passportView
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
        
        view.addSubview(passportView)
        passportView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        passportView.modelBlock = { [weak self] type in
            guard let self = self else { return }
            let uploadVc = UploadFaceViewController()
            uploadVc.type = type
            uploadVc.productID = productID
            self.navigationController?.pushViewController(uploadVc, animated: true)
        }
        
    }

}

