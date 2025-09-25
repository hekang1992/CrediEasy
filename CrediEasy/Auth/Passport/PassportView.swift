//
//  PassportView.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/15.
//

import UIKit

class PassportView: BaseView {
    
    var model: andeModel?
    
    var modelBlock: ((String) -> Void)?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.text = "Please select the appropriate authentication method"
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(800))
        return nameLabel
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "list_passpord_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hexString: "#0073E5")
        oneLabel.textAlignment = .left
        oneLabel.text = "Recommend"
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hexString: "#0073E5")
        twoLabel.textAlignment = .left
        twoLabel.text = "Other"
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return twoLabel
    }()
    
    lazy var oneTableView: UITableView = {
        let oneTableView = UITableView(frame: .zero, style: .plain)
        oneTableView.separatorStyle = .none
        oneTableView.backgroundColor = .clear
        oneTableView.register(PassportViewCell.self,
                              forCellReuseIdentifier: "PassportViewCell1")
        oneTableView.estimatedRowHeight = 80
        oneTableView.showsVerticalScrollIndicator = true
        oneTableView.showsHorizontalScrollIndicator = true
        oneTableView.contentInsetAdjustmentBehavior = .never
        oneTableView.rowHeight = UITableView.automaticDimension
        oneTableView.delegate = self
        oneTableView.dataSource = self
        if #available(iOS 15.0, *) {
            oneTableView.sectionHeaderTopPadding = 0
        }
        return oneTableView
    }()
    
    lazy var twoTableView: UITableView = {
        let twoTableView = UITableView(frame: .zero, style: .plain)
        twoTableView.separatorStyle = .none
        twoTableView.backgroundColor = .clear
        twoTableView.register(PassportViewCell.self,
                              forCellReuseIdentifier: "PassportViewCell2")
        twoTableView.estimatedRowHeight = 80
        twoTableView.showsVerticalScrollIndicator = true
        twoTableView.showsHorizontalScrollIndicator = true
        twoTableView.contentInsetAdjustmentBehavior = .never
        twoTableView.rowHeight = UITableView.automaticDimension
        twoTableView.delegate = self
        twoTableView.dataSource = self
        if #available(iOS 15.0, *) {
            twoTableView.sectionHeaderTopPadding = 0
        }
        return twoTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(oneTableView)
        bgImageView.addSubview(twoTableView)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(35)
            make.height.equalTo(45)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.right.bottom.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 939))
            make.bottom.equalToSuperview().offset(-20)
        }
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.left.equalToSuperview().offset(34)
            make.height.equalTo(17)
        }
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(434)
            make.left.equalToSuperview().offset(34)
            make.height.equalTo(17)
        }
        oneTableView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(370)
            make.centerX.equalToSuperview()
        }
        twoTableView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(370)
            make.centerX.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PassportView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == oneTableView {
            return model?.prefelic?.count ?? 0
        }else {
            return model?.evaporize?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == oneTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassportViewCell1", for: indexPath) as! PassportViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.nameLabel.text = model?.prefelic?[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassportViewCell2", for: indexPath) as! PassportViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.nameLabel.text = model?.evaporize?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == oneTableView {
            let modelArray = model?.prefelic ?? []
            self.modelBlock?(modelArray[indexPath.row])
        }else {
            let modelArray = model?.evaporize ?? []
            self.modelBlock?(modelArray[indexPath.row])
        }
    }
    
}
