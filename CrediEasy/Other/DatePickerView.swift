//
//  PickDateView.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/18.
//

import UIKit
import SnapKit

class DatePickerView: UIView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "cover_li_image")
        return bgImageView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "f_birth_image")
        headImageView.contentMode = .scaleAspectFit
        return headImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "cancel_lis_image"), for: .normal)
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setTitle("Confirm", for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        sureBtn.layer.cornerRadius = 27
        sureBtn.layer.masksToBounds = true
        return sureBtn
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "en_US")
        return picker
    }()
    
    var onDateChanged: ((String) -> Void)?
    
    init(frame: CGRect, defaultDateString: String, format: String = "yyyy-dd-MM") {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(cancelBtn)
        bgView.addSubview(bgImageView)
        bgView.addSubview(headImageView)
        bgView.addSubview(sureBtn)
        bgView.addSubview(datePicker)
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let parsedDate = formatter.date(from: defaultDateString) {
            datePicker.date = parsedDate
            updateLabel(with: parsedDate)
        } else {
            datePicker.date = Date()
            updateLabel(with: Date())
        }
        
        bgView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(427)
        }
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(181)
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 202, height: 24))
        }
        cancelBtn.snp.makeConstraints { make in
            make.centerY.equalTo(headImageView.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-40)
        }
        datePicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(5)
            make.bottom.equalTo(sureBtn.snp.top).offset(-5)
        }
        
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        updateLabel(with: sender.date)
    }
    
    private func updateLabel(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        let dateString = formatter.string(from: date)
        onDateChanged?(dateString)
        print("Selected Date: \(dateString)")
    }
    
}
