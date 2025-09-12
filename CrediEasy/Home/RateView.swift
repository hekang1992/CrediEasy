//
//  RateView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/11.
//

import UIKit

class RateView: BaseView {
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.textColor = UIColor.init(hexString: "#1C2123")
        desclabel.textAlignment = .left
        desclabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return desclabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(desclabel)
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
        desclabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(17)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
