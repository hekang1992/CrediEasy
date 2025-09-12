//
//  CenterView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/10.
//

import UIKit

class CenterView: BaseView {
    
    var modelClickBlock: ((buoyedModel?) -> Void)?
    
    var modelArray: [buoyedModel]?

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0073E5")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        nameLabel.text = "Mine"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 25
        return whiteView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "center_logo_image")
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var userLabel: UILabel = {
        let userLabel = UILabel(frame: .zero)
        userLabel.text = "User"
        userLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(800))
        userLabel.textColor = UIColor.init(hexString: "#001E3B")
        userLabel.textAlignment = .center
        return userLabel
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel(frame: .zero)
        phoneLabel.text = "****"
        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        phoneLabel.textColor = UIColor.init(hexString: "#004A92")
        phoneLabel.textAlignment = .center
        return phoneLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(CenterViewCell.self,
                           forCellReuseIdentifier: "CenterViewCell")
        tableView.estimatedRowHeight = 50
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(whiteView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(userLabel)
        bgView.addSubview(phoneLabel)
        bgView.addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            make.size.equalTo(CGSize(width: 200, height: 20))
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(90)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(50)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(whiteView.snp.top).offset(-50)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        userLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 24))
            make.top.equalTo(logoImageView.snp.bottom).offset(6)
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 20))
            make.top.equalTo(userLabel.snp.bottom).offset(4)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(40)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CenterView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenterViewCell", for: indexPath) as! CenterViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if let model = self.modelArray?[indexPath.row] {
            cell.model = model
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.modelArray?[indexPath.row] {
            self.modelClickBlock?(model)
        }
    }
    
}
