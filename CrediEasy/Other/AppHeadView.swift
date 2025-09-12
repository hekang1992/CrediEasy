//
//  AppHeadView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit

class AppHeadView: BaseView {
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "app_back_image"), for: .normal)
        return backBtn
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(hexString: "#FFFFFF")
        namelabel.textAlignment = .center
        namelabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return namelabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(namelabel)
        
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        namelabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 34))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
