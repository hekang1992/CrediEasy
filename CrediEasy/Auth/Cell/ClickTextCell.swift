//
//  Untitled.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit

class ClickTextCell: BaseViewCell {
    
    var model: interspicularModel? {
        didSet {
            guard let model = model else { return }
            phoneTx.text = model.hydrophoria ?? ""
            nameLabel.text = model.identifiable ?? ""
            phoneTx.placeholder = model.identifiable ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        return bgView
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
        phoneTx.textColor = .black
        return phoneTx
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(phoneTx)
        bgView.addSubview(clickBtn)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.height.equalTo(17)
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-14)
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
