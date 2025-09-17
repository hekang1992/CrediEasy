//
//  AppStepViewViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit

class AppStepViewViewController: BaseViewController {
    
    var productID: String = ""
    
    let viewModel = DetailViewModel.shared
    
    lazy var oneView: RateView = {
        let oneView = RateView()
        oneView.logoImageView.image = UIImage(named: "day_li_oiamge")
        oneView.desclabel.textColor = .white
        return oneView
    }()
    
    lazy var twoView: RateView = {
        let twoView = RateView()
        twoView.logoImageView.image = UIImage(named: "rate_li_cimage")
        twoView.desclabel.textColor = .white
        return twoView
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        moneyLabel.textAlignment = .left
        moneyLabel.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(800))
        return moneyLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#ECF5FE")
        return bgView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(StepViewCell.self,
                           forCellReuseIdentifier: "StepViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        applyBtn.layer.cornerRadius = 27
        applyBtn.layer.masksToBounds = true
        return applyBtn
    }()
    
    lazy var priImageView: UIImageView = {
        let priImageView = UIImageView()
        priImageView.image = UIImage(named: "pri_li_step_image")
        priImageView.isUserInteractionEnabled = true
        return priImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#0073E5")
        
        view.addSubview(headView)
        
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        view.addSubview(moneyLabel)
        view.addSubview(oneView)
        view.addSubview(twoView)
        
        view.addSubview(bgView)
        view.addSubview(tableView)
        
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.headView.snp.bottom).offset(17)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }
        oneView.snp.makeConstraints { make in
            make.top.equalTo(moneyLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 110, height: 26))
        }
        twoView.snp.makeConstraints { make in
            make.centerY.equalTo(oneView.snp.centerY)
            make.left.equalTo(oneView.snp.right).offset(20)
            make.size.equalTo(CGSize(width: 110, height: 26))
        }
        
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(oneView.snp.bottom).offset(70)
            make.bottom.equalToSuperview().offset(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(bgView.snp.top).offset(-40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-105)
        }
        
        view.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 54))
        }
        
        view.addSubview(priImageView)
        priImageView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.size.equalTo(CGSize(width: 375, height: 50))
            make.centerX.equalToSuperview()
        }
        
        viewModel.detailModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            let simple = model.ande?.feliciana?.symbol ?? ""
            let foliature = model.ande?.feliciana?.foliature ?? 0
            headView.namelabel.text = model.ande?.feliciana?.saxcornet ?? ""
            moneyLabel.text = simple + "\(foliature)"
            oneView.desclabel.text = model.ande?.feliciana?.lutes?.sunned?.unrecreant ?? ""
            twoView.desclabel.text = model.ande?.feliciana?.lutes?.nickled?.unrecreant ?? ""
            applyBtn.setTitle(model.ande?.feliciana?.consuelo ?? "", for: .normal)
        }).disposed(by: disposeBag)
        
        viewModel.listModelArray.asObservable().bind(to: tableView.rx.items(cellIdentifier: "StepViewCell", cellType: StepViewCell.self)) { row, model, cell in
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
        }.disposed(by: disposeBag)
        
        viewModel.detailApplyModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            let epees = model.ande?.kinematograph?.epees ?? ""
            if epees == "renerve" {
                viewModel.getIDetaiInfo(productID: productID)
            }else if epees == "phenogenesis" {
                let personalVc = PersonalViewController()
                personalVc.productID = productID
                personalVc.pagetitle = model.ande?.kinematograph?.spermatogonia ?? ""
                self.navigationController?.pushViewController(personalVc, animated: true)
            }else if epees == "pinioned" {
                let lifeVc = LifeGoodViewController()
                lifeVc.productID = productID
                lifeVc.pagetitle = model.ande?.kinematograph?.spermatogonia ?? ""
                self.navigationController?.pushViewController(lifeVc, animated: true)
            }else if epees == "Sparidae" {
                let loveVc = LoveLifeViewController()
                loveVc.productID = productID
                loveVc.pagetitle = model.ande?.kinematograph?.spermatogonia ?? ""
                self.navigationController?.pushViewController(loveVc, animated: true)
            }else if epees == "tykhana" {
                let cidVc = ChangeCidViewController()
                cidVc.productID = productID
                cidVc.pagetitle = model.ande?.kinematograph?.spermatogonia ?? ""
                let pageUrl = model.ande?.kinematograph?.roguy ?? ""
                cidVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(cidVc, animated: true)
            }
        }).disposed(by: disposeBag)
        
        viewModel.idModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            if model.ande?.foxtrot?.ideist == 0 {
                let passVc = PassportViewController()
                passVc.productID = productID
                passVc.model = model
                self.navigationController?.pushViewController(passVc, animated: true)
            }else {
                let passVc = UploadFaceViewController()
                passVc.productID = productID
                self.navigationController?.pushViewController(passVc, animated: true)
            }
        }).disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(beakfulModel.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                judgeAuthSetpWithModel(form: model, productID: productID)
            }).disposed(by: disposeBag)
        
        
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            viewModel.getProductDetaiInfo(productID: productID, isTap: true)
        }).disposed(by: disposeBag)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.viewModel.getProductDetaiInfo(productID: self.productID, isTap: false)
        }
    }
    
}

extension AppStepViewViewController {
    
    private func judgeAuthSetpWithModel(form model: beakfulModel,
                                        productID: String) {
        let ideist = model.ideist ?? 0
        let epees = model.epees ?? ""
        if ideist == 0 {
            if epees == "renerve" {
                judgeID(productID: productID)
            }else  {
                let viewModel = DetailViewModel.shared
                viewModel.getProductDetaiInfo(productID: productID, isTap: true)
            }
        }else {
            if epees == "renerve" {
                let passVc = UploadFaceViewController()
                passVc.productID = productID
                self.navigationController?.pushViewController(passVc, animated: true)
            }else if epees == "phenogenesis" {
                let personalVc = PersonalViewController()
                personalVc.productID = productID
                personalVc.pagetitle = model.spermatogonia ?? ""
                self.navigationController?.pushViewController(personalVc, animated: true)
            }else if epees == "pinioned" {
                let lifeVc = LifeGoodViewController()
                lifeVc.productID = productID
                lifeVc.pagetitle = model.spermatogonia ?? ""
                self.navigationController?.pushViewController(lifeVc, animated: true)
            }else if epees == "Sparidae" {
                let loveVc = LoveLifeViewController()
                loveVc.productID = productID
                loveVc.pagetitle = model.spermatogonia ?? ""
                self.navigationController?.pushViewController(loveVc, animated: true)
            }else if epees == "tykhana" {
                let cidVc = ChangeCidViewController()
                cidVc.productID = productID
                cidVc.pagetitle = model.spermatogonia ?? ""
                let pageUrl = model.roguy ?? ""
                cidVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(cidVc, animated: true)
            }
        }
    }
    
    private func judgeID(productID: String) {
        viewModel.getIDetaiInfo(productID: productID)
    }
    
}
