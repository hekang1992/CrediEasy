//
//  PopImageView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit
import TYAlertController

class PopImageView: BaseView {
    
    var modelArray: [interspicularModel]?
    
    var dateBlock: ((ClickTextCell) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#F2F8FC")
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "cover_li_image")
        return bgImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "succ_im_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "de_ac_iamge")
        return twoImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "cancel_lis_image"), for: .normal)
        return cancelBtn
    }()
    
    lazy var saveBtn: UIButton = {
        let saveBtn = UIButton(type: .custom)
        saveBtn.setTitle("Confirm", for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        saveBtn.layer.cornerRadius = 27
        saveBtn.layer.masksToBounds = true
        return saveBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(InputTextCell.self, forCellReuseIdentifier: "InputTextCell")
        tableView.register(ClickTextCell.self, forCellReuseIdentifier: "ClickTextCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(twoImageView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(oneImageView)
        bgView.addSubview(saveBtn)
        bgView.addSubview(tableView)
        bgView.addSubview(cancelBtn)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(427)
        }
        bgImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(181)
        }
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 179, height: 40))
        }
        twoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(bgView.snp.top).offset(-45)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        saveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 335, height: 54))
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(14)
            make.bottom.equalTo(saveBtn.snp.top).offset(-1)
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopImageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray?[indexPath.row]
        if model?.larcenable == "phratry" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClickTextCell", for: indexPath) as! ClickTextCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            cell.clickBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.dateBlock?(cell)
            }).disposed(by: disposeBag)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextCell", for: indexPath) as! InputTextCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            return cell
        }
    }
    
}

extension PopImageView {
    
    
}
