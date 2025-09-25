//
//  ImageListView.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/15.
//

import UIKit

class ImageListView: BaseView {
    
    lazy var cardLabel: UILabel = {
        let cardLabel = UILabel()
        cardLabel.textColor = UIColor.init(hexString: "#1C2123")
        cardLabel.textAlignment = .left
        cardLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return cardLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#0073E5")
        return bgView
    }()
    
    lazy var menuView: UIView = {
        let menuView = UIView()
        menuView.layer.cornerRadius = 25
        menuView.layer.masksToBounds = true
        menuView.backgroundColor = UIColor.init(hexString: "#E9F2F9")
        return menuView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        descLabel.textAlignment = .center
        descLabel.text = "Upload"
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return descLabel
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.contentMode = .scaleAspectFit
        return descImageView
    }()
    
    lazy var gouImageView: UIImageView = {
        let gouImageView = UIImageView()
        gouImageView.image = UIImage(named: "su_gou_image")
        gouImageView.isHidden = true
        return gouImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cardLabel)
        addSubview(bgView)
        bgView.addSubview(menuView)
        bgView.addSubview(descLabel)
        menuView.addSubview(descImageView)
        menuView.addSubview(gouImageView)
        cardLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(17)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(cardLabel.snp.bottom).offset(16)
            make.height.equalTo(202)
        }
        menuView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        descImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 210, height: 150))
        }
        gouImageView.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 45, height: 32))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
