//
//  CenterListView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit

class CenterListView: BaseView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "right_list_image")
        rightImageView.contentMode = .scaleAspectFit
        return rightImageView
    }()
    
    lazy var letImageView: UIImageView = {
        let letImageView = UIImageView()
        letImageView.contentMode = .scaleAspectFit
        return letImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(hexString: "#1C2123")
        namelabel.textAlignment = .left
        namelabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return namelabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(letImageView)
        bgView.addSubview(namelabel)
        bgView.addSubview(rightImageView)
        
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        letImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        namelabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(letImageView.snp.right).offset(12)
            make.height.equalTo(17)
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-14)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
