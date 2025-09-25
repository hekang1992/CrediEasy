//
//  LoveLifeViewCell.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/17.
//

import UIKit

class LoveLifeViewCell: BaseViewCell {
    
    var model: revolutionisedModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.spermatogonia ?? ""
            phoneTx.placeholder = model.geigy ?? ""
            phoneNumberTx.placeholder = model.freit ?? ""
            
            phoneTx.text = model.whens ?? ""
            
            let name = model.banshees ?? ""
            let semaphorically = model.semaphorically ?? ""
            let npInfo = "\(name)-\(semaphorically)"
            phoneNumberTx.text = npInfo == "-" ? "" : npInfo
        }
    }
    
    lazy var relationView: UIView = {
        let relationView = UIView()
        relationView.backgroundColor = .white
        relationView.layer.cornerRadius = 25
        relationView.layer.masksToBounds = true
        return relationView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Your name"
        nameLabel.textColor = UIColor.init(hexString: "#1C2123")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(600))
        return nameLabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        let attrString = NSMutableAttributedString(string: "", attributes: [
            .foregroundColor: UIColor.init(hexString: "#CCDAE9") as Any,
            .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(500))
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(500))
        phoneTx.textColor = UIColor.init(hexString: "#0073E5")
        phoneTx.isEnabled = true
        return phoneTx
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "right_list_image")
        return rightImageView
    }()
    
    lazy var phoneView: UIView = {
        let phoneView = UIView()
        phoneView.backgroundColor = .white
        phoneView.layer.cornerRadius = 25
        phoneView.layer.masksToBounds = true
        return phoneView
    }()
    
    lazy var phoneNumberTx: UITextField = {
        let phoneNumberTx = UITextField()
        let attrString = NSMutableAttributedString(string: "", attributes: [
            .foregroundColor: UIColor.init(hexString: "#CCDAE9") as Any,
            .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(500))
        ])
        phoneNumberTx.attributedPlaceholder = attrString
        phoneNumberTx.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(500))
        phoneNumberTx.textColor = UIColor.init(hexString: "#0073E5")
        phoneNumberTx.isEnabled = true
        return phoneNumberTx
    }()
    
    lazy var clickPhoneBtn: UIButton = {
        let clickPhoneBtn = UIButton(type: .custom)
        return clickPhoneBtn
    }()
    
    lazy var rightPhoneImageView: UIImageView = {
        let rightPhoneImageView = UIImageView()
        rightPhoneImageView.image = UIImage(named: "pp_list_a_image")
        return rightPhoneImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(relationView)
        relationView.addSubview(rightImageView)
        relationView.addSubview(phoneTx)
        relationView.addSubview(clickBtn)
        
        contentView.addSubview(phoneView)
        phoneView.addSubview(rightPhoneImageView)
        phoneView.addSubview(phoneNumberTx)
        phoneView.addSubview(clickPhoneBtn)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.height.equalTo(17)
        }
        relationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(54)
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
        }
        rightImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        phoneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(relationView.snp.bottom).offset(10)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-14)
        }
        phoneNumberTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
        }
        rightPhoneImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        clickPhoneBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
