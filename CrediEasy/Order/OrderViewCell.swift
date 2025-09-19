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
    
    lazy var typrImageView: UIImageView = {
        let typrImageView = UIImageView()
        return typrImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(lineImageView)
        contentView.addSubview(typrImageView)
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
        typrImageView.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right)
            make.top.equalTo(bgImageView.snp.top)
            make.size.equalTo(CGSize(width: 123, height: 27))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

