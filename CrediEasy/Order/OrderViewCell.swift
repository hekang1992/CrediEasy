//
//  OrderViewCell.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit

class OrderViewCell: BaseViewCell {
    
    var model: buoyedModel? {
        didSet {
            guard let model = model else { return }
            let opinicuses = model.opinicuses ?? ""
            if opinicuses.isEmpty {
                bgImageView.image = UIImage(named: "no_type_image")
            }else {
                bgImageView.image = UIImage(named: "have_type_limge")
            }
            typrBtn.setTitle(model.consuelo ?? "", for: .normal)
            logoImageView.kf.setImage(with: URL(string: model.crackrope ?? ""))
            descLabel.text = model.arched ?? ""
            moneyLabel.text = model.concentre ?? ""
            timeLabel.text = "\(model.refool ?? ""): \((model.nonmarveling ?? ""))"
            nameLabel.text = model.saxcornet ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var lineImageView: UIImageView = {
        let lineImageView = UIImageView()
        lineImageView.image = UIImage(named: "ce_or_line_image")
        return lineImageView
    }()
    
    lazy var typrBtn: UIButton = {
        let typrBtn = UIButton(type: .custom)
        typrBtn.setBackgroundImage(UIImage(named: "ty_oc_ili_amge"), for: .normal)
        typrBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        typrBtn.titleLabel?.numberOfLines = 2
        typrBtn.setTitleColor(UIColor.init(hexString: "#146CC4"), for: .normal)
        typrBtn.titleEdgeInsets = UIEdgeInsets(top: -2, left: 2, bottom: -2, right: 2)
        return typrBtn
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(600))
        descLabel.textColor = UIColor.init(hexString: "#001E3B")
        return descLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(700))
        moneyLabel.textColor = UIColor.init(hexString: "#0073E5")
        return moneyLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textAlignment = .left
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        timeLabel.textColor = UIColor.init(hexString: "#94A8BB")
        return timeLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .right
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(600))
        nameLabel.textColor = UIColor.init(hexString: "#001E3B")
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(lineImageView)
        contentView.addSubview(typrBtn)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(moneyLabel)
        bgImageView.addSubview(timeLabel)
        bgImageView.addSubview(nameLabel)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.bottom.equalToSuperview().offset(-8)
        }
        lineImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(94)
            make.size.equalTo(CGSize(width: 288, height: 1))
        }
        typrBtn.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.top.equalTo(bgImageView.snp.top)
            make.size.equalTo(CGSize(width: 123, height: 27))
        }
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 58, height: 58))
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(15)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(2)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(24)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(moneyLabel.snp.bottom).offset(2)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(15)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(15)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

