//
//  LoginView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit

class LoginView: BaseView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#0073E5")
        return bgView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "login_head_image")
        headImageView.contentMode = .scaleAspectFit
        return headImageView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var phonelabel: UILabel = {
        let phonelabel = UILabel()
        phonelabel.text = "Moblie Phone Number(+63)"
        phonelabel.textColor = UIColor.init(hexString: "#004A92")
        phonelabel.textAlignment = .left
        phonelabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return phonelabel
    }()
    
    lazy var phoneBgImageView: UIImageView = {
        let phoneBgImageView = UIImageView()
        phoneBgImageView.image = UIImage(named: "angle_image")
        phoneBgImageView.contentMode = .scaleAspectFit
        phoneBgImageView.isUserInteractionEnabled = true
        return phoneBgImageView
    }()
    
    lazy var alabel: UILabel = {
        let alabel = UILabel()
        alabel.text = "+63"
        alabel.textColor = UIColor.init(hexString: "#CCDAE9")
        alabel.textAlignment = .center
        alabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return alabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hexString: "#CCDAE9")
        lineView.layer.cornerRadius = 5
        lineView.layer.masksToBounds = true
        return lineView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Please enter your phone number", attributes: [
            .foregroundColor: UIColor.init(hexString: "#CCDAE9") as Any,
            .font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        phoneTx.textColor = .black
        phoneTx.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return phoneTx
    }()
    
    lazy var codelabel: UILabel = {
        let codelabel = UILabel()
        codelabel.text = "Verification Code"
        codelabel.textColor = UIColor.init(hexString: "#004A92")
        codelabel.textAlignment = .left
        codelabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return codelabel
    }()
    
    lazy var codeBgImageView: UIImageView = {
        let codeBgImageView = UIImageView()
        codeBgImageView.image = UIImage(named: "angle_image")
        codeBgImageView.contentMode = .scaleAspectFit
        codeBgImageView.isUserInteractionEnabled = true
        return codeBgImageView
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter verification Code", attributes: [
            .foregroundColor: UIColor.init(hexString: "#CCDAE9") as Any,
            .font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        codeTx.textColor = .black
        return codeTx
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.setTitle("Send", for: .normal)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        sendBtn.setTitleColor(.white, for: .normal)
        sendBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        sendBtn.layer.cornerRadius = 22
        sendBtn.layer.masksToBounds = true
        return sendBtn
    }()
    
    lazy var voiceBtn: UIButton = {
        let voiceBtn = UIButton(type: .custom)
        voiceBtn.setImage(UIImage(named: "voice_image"), for: .normal)
        return voiceBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Log In", for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        loginBtn.layer.cornerRadius = 27
        loginBtn.layer.masksToBounds = true
        return loginBtn
    }()
    
    lazy var agreementLabel: UILabel = {
        let agreementLabel = UILabel()
        agreementLabel.numberOfLines = 0
        let baseString = "By logging in, you agree to our Privacy Policy."
        let attributedString = NSMutableAttributedString(string: baseString)
        let entireAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.init(hexString: "#001E3C")
        ]
        attributedString.addAttributes(entireAttributes, range: NSRange(location: 0, length: baseString.count))
        let linkText = "Privacy Policy"
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
        agreeBtn.isSelected = true
        agreeBtn.setImage(UIImage(named: "login_nor_image"), for: .normal)
        agreeBtn.setImage(UIImage(named: "login_sel_image"), for: .selected)
        return agreeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(headImageView)
        bgView.addSubview(whiteView)
        whiteView.addSubview(phonelabel)
        whiteView.addSubview(phoneBgImageView)
        phoneBgImageView.addSubview(alabel)
        phoneBgImageView.addSubview(lineView)
        phoneBgImageView.addSubview(phoneTx)
        whiteView.addSubview(codelabel)
        whiteView.addSubview(codeBgImageView)
        codeBgImageView.addSubview(codeTx)
        codeBgImageView.addSubview(sendBtn)
        whiteView.addSubview(voiceBtn)
        whiteView.addSubview(loginBtn)
        whiteView.addSubview(agreementLabel)
        whiteView.addSubview(agreeBtn)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 216))
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(382)
            make.width.equalTo(320)
        }
        phonelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(17)
        }
        phoneBgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 287, height: 48))
            make.centerX.equalToSuperview()
            make.top.equalTo(phonelabel.snp.bottom).offset(10)
        }
        alabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(18)
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(alabel.snp.right).offset(8)
            make.size.equalTo(CGSize(width: 2, height: 15))
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-5)
            make.top.bottom.equalToSuperview()
        }
        codelabel.snp.makeConstraints { make in
            make.top.equalTo(phoneBgImageView.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(17)
        }
        codeBgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 287, height: 48))
            make.centerX.equalToSuperview()
            make.top.equalTo(codelabel.snp.bottom).offset(10)
        }
        codeTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(200)
            make.top.bottom.equalToSuperview()
        }
        sendBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.centerY.equalToSuperview()
        }
        voiceBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeBgImageView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 157, height: 24))
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(voiceBtn.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 285, height: 54))
        }
        agreementLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(15)
            make.top.equalTo(loginBtn.snp.bottom).offset(14)
            make.width.equalTo(259)
        }
        agreeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(agreementLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.right.equalTo(agreementLabel.snp.left).offset(-5)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count != 0 {
            alabel.textColor = UIColor.init(hexString: "#004A92")
        }else {
            alabel.textColor = UIColor.init(hexString: "#CCDAE9")
        }
        
    }
    
}

