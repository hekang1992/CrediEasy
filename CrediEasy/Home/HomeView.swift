//
//  HomeView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/10.
//

import UIKit

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

class HomeView: BaseView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.init(hexString: "#FAFBFC")
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "home_head_image")
        return headImageView
    }()
    
    lazy var applyImageView: UIImageView = {
        let applyImageView = UIImageView()
        applyImageView.image = UIImage(named: "home_apply_image")
        applyImageView.isUserInteractionEnabled = true
        return applyImageView
    }()
    
    lazy var onelabel: UILabel = {
        let onelabel = UILabel()
        onelabel.text = "Our Advantages"
        onelabel.textColor = UIColor.init(hexString: "#1C2123")
        onelabel.textAlignment = .left
        onelabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return onelabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "home_desc_image")
        return oneImageView
    }()
    
    lazy var twolabel: UILabel = {
        let twolabel = UILabel()
        twolabel.text = "Customer reviews"
        twolabel.textColor = UIColor.init(hexString: "#1C2123")
        twolabel.textAlignment = .left
        twolabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return twolabel
    }()
    
    lazy var minScrollView: UIScrollView = {
        let minScrollView = UIScrollView()
        minScrollView.backgroundColor = UIColor.clear
        minScrollView.showsHorizontalScrollIndicator = false
        minScrollView.showsVerticalScrollIndicator = false
        minScrollView.contentInsetAdjustmentBehavior = .never
        return minScrollView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "comm_one_imge")
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "comm_two_imge")
        return threeImageView
    }()
    
    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "comm_three_imge")
        return fourImageView
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.text = "Maximum loan amount"
        desclabel.textColor = UIColor.init(hexString: "#999B9C")
        desclabel.textAlignment = .left
        desclabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return desclabel
    }()
    
    lazy var moneylabel: UILabel = {
        let moneylabel = UILabel()
        moneylabel.text = "₱120,000"
        moneylabel.textColor = UIColor.init(hexString: "#1C2123")
        moneylabel.textAlignment = .left
        moneylabel.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(800))
        return moneylabel
    }()
    
    lazy var oneView: RateView = {
        let oneView = RateView()
        oneView.logoImageView.image = UIImage(named: "rate_list_image")
        oneView.desclabel.text = "91-240day"
        return oneView
    }()
    
    lazy var twoView: RateView = {
        let twoView = RateView()
        twoView.logoImageView.image = UIImage(named: "rae_li_image")
        twoView.desclabel.text = "0.05%/day"
        return twoView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitle("Obtain loan amount", for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        applyBtn.layer.cornerRadius = 27
        applyBtn.layer.masksToBounds = true
        return applyBtn
    }()
    
    lazy var agreementLabel: UILabel = {
        let agreementLabel = UILabel()
        agreementLabel.numberOfLines = 0
        let baseString = "I have read and agree to the loan terms."
        let attributedString = NSMutableAttributedString(string: baseString)
        let entireAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.init(hexString: "#001E3C")
        ]
        attributedString.addAttributes(entireAttributes, range: NSRange(location: 0, length: baseString.count))
        let linkText = "loan terms"
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
        addSubview(scrollView)
        scrollView.addSubview(headImageView)
        scrollView.addSubview(applyImageView)
        scrollView.addSubview(onelabel)
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twolabel)
        scrollView.addSubview(minScrollView)
        minScrollView.addSubview(twoImageView)
        minScrollView.addSubview(threeImageView)
        minScrollView.addSubview(fourImageView)
        
        applyImageView.addSubview(desclabel)
        applyImageView.addSubview(moneylabel)
        applyImageView.addSubview(oneView)
        applyImageView.addSubview(twoView)
        applyImageView.addSubview(applyBtn)
        
        applyImageView.addSubview(agreementLabel)
        applyImageView.addSubview(agreeBtn)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        headImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(screen_width)
            make.height.equalTo(277)
        }
        applyImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 340, height: 245))
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(-45)
        }
        onelabel.snp.makeConstraints { make in
            make.left.equalTo(applyImageView.snp.left)
            make.top.equalTo(applyImageView.snp.bottom).offset(12)
            make.height.equalTo(20)
        }
        oneImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 375, height: 300))
            make.centerX.equalToSuperview()
            make.top.equalTo(onelabel.snp.bottom).offset(12)
        }
        twolabel.snp.makeConstraints { make in
            make.left.equalTo(applyImageView.snp.left)
            make.top.equalTo(oneImageView.snp.bottom).offset(12)
            make.height.equalTo(20)
        }
        minScrollView.snp.makeConstraints { make in
            make.top.equalTo(twolabel.snp.bottom).offset(12)
            make.left.equalToSuperview()
            make.width.equalTo(screen_width)
            make.height.equalTo(190)
            make.bottom.equalToSuperview().offset(-5)
        }
        twoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 143, height: 180))
        }
        threeImageView.snp.makeConstraints { make in
            make.left.equalTo(twoImageView.snp.right).offset(16)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 143, height: 180))
        }
        fourImageView.snp.makeConstraints { make in
            make.left.equalTo(threeImageView.snp.right).offset(16)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 143, height: 180))
            make.right.equalToSuperview().offset(-20)
        }
        desclabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(17)
        }
        moneylabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(desclabel.snp.bottom).offset(6)
            make.height.equalTo(44)
        }
        oneView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(moneylabel.snp.bottom).offset(12)
            make.height.equalTo(26)
            make.width.equalTo(110)
        }
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(20)
            make.top.equalTo(moneylabel.snp.bottom).offset(12)
            make.height.equalTo(26)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoView.snp.bottom).offset(24)
            make.size.equalTo(CGSize(width: 295, height: 54))
        }
        agreementLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(20)
            make.top.equalTo(applyBtn.snp.bottom).offset(12)
            make.height.equalTo(14)
        }
        agreeBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 13, height: 13))
            make.centerY.equalTo(agreementLabel.snp.centerY)
            make.right.equalTo(agreementLabel.snp.left).offset(-5)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
