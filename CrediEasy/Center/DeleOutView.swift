//
//  DeleOutView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit

class DeleteView: BaseView {
    
    lazy var popImageView: UIImageView = {
        let popImageView = UIImageView()
        popImageView.image = UIImage(named: "del_app_image")
        popImageView.isUserInteractionEnabled = true
        popImageView.contentMode = .scaleAspectFit
        return popImageView
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        return rightBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(popImageView)
        popImageView.addSubview(leftBtn)
        popImageView.addSubview(rightBtn)
        popImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 307, height: 283))
        }
        
        leftBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 80))
        }
        rightBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 80))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LogOutView: BaseView {
    
    lazy var popImageView: UIImageView = {
        let popImageView = UIImageView()
        popImageView.image = UIImage(named: "out_app_image")
        popImageView.isUserInteractionEnabled = true
        popImageView.contentMode = .scaleAspectFit
        return popImageView
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        return rightBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(popImageView)
        popImageView.addSubview(leftBtn)
        popImageView.addSubview(rightBtn)
        popImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 307, height: 234))
        }
        
        leftBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 80))
        }
        rightBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 80))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
