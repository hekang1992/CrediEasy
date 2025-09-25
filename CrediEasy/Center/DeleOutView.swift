//
//  DeleOutView.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/12.
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
    
    lazy var agreementLabel: UILabel = {
        let agreementLabel = UILabel()
        agreementLabel.numberOfLines = 0
        let baseString = "I have read and agree to the above."
        let attributedString = NSMutableAttributedString(string: baseString)
        let entireAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.init(hexString: "#001E3C")
        ]
        attributedString.addAttributes(entireAttributes, range: NSRange(location: 0, length: baseString.count))
        let linkText = ""
        if let linkRange = baseString.range(of: linkText) {
            let nsRange = NSRange(linkRange, in: baseString)
            attributedString.addAttributes([
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: nsRange)
        }
        agreementLabel.attributedText = attributedString
        return agreementLabel
    }()
    
    lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton(type: .custom)
        agreeBtn.setImage(UIImage(named: "login_nor_image"), for: .normal)
        agreeBtn.setImage(UIImage(named: "login_sel_image"), for: .selected)
        return agreeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(popImageView)
        popImageView.addSubview(agreementLabel)
        popImageView.addSubview(agreeBtn)
        popImageView.addSubview(leftBtn)
        popImageView.addSubview(rightBtn)
        popImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 307, height: 283))
        }
        agreeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(195)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        agreementLabel.snp.makeConstraints { make in
            make.centerY.equalTo(agreeBtn.snp.centerY)
            make.height.equalTo(15)
            make.left.equalTo(agreeBtn.snp.right).offset(5)
        }
        
        leftBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 50))
        }
        rightBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 50))
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

class LeaveView: BaseView {
    
    lazy var popImageView: UIImageView = {
        let popImageView = UIImageView()
        popImageView.image = UIImage(named: "leave_li_image")
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
            make.size.equalTo(CGSize(width: 307, height: 263))
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
