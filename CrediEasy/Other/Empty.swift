//
//  Empty.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/19.
//

import UIKit

class EmptyView: BaseView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "emp_im_image")
        return bgImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "No orders at the moment"
        descLabel.textColor = .white
        descLabel.textAlignment = .center
        descLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(600))
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(descLabel)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 257, height: 257))
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(2)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
