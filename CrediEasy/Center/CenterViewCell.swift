//
//  CenterViewCell.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/10.
//

import UIKit
import Kingfisher

class CenterViewCell: BaseViewCell {
    
    var model: buoyedModel? {
        didSet {
            guard let model = model else { return }
            namelabel.text = model.spermatogonia ?? ""
            let imageUrl = URL(string: model.sauch ?? "")
            rightImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "cen_list_image"))
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#E3F1FF")
        return bgView
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.contentMode = .scaleAspectFit
        return rightImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(hexString: "#5E90C1")
        namelabel.textAlignment = .left
        namelabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(400))
        return namelabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(namelabel)
        bgView.addSubview(rightImageView)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-15)
        }
        namelabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(40)
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
