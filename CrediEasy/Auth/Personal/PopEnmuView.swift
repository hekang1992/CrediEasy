//
//  PopEnmuView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/17.
//

import UIKit

class PopEnmuView: BaseView {
    
    private var selectedRow: Int = 0
    
    var model: revolutionisedModel? {
        didSet {
            guard let model = model else { return }
        }
    }
    
    
    var sureBlock: ((Int) -> Void)?
    
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
        headImageView.image = UIImage(named: "chose_l_imge")
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
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(cancelBtn)
        bgView.addSubview(bgImageView)
        bgView.addSubview(headImageView)
        bgView.addSubview(sureBtn)
        bgView.addSubview(pickerView)
        
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
            make.size.equalTo(CGSize(width: 167, height: 24))
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
        pickerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(5)
            make.bottom.equalTo(sureBtn.snp.top).offset(-5)
        }
        
        sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.sureBlock?(selectedRow)
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PopEnmuView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.model?.scalping?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let model = self.model?.scalping?[row]
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = model?.banshees ?? ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        
        if row == selectedRow {
//            label.backgroundColor = UIColor.init(hexString: "#DAEFFA")
            label.textColor = UIColor.init(hexString: "#0073E5")
        } else {
            label.backgroundColor = .clear
            label.textColor = .black
        }
        
        containerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        return containerView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        pickerView.reloadAllComponents()
        let model = self.model?.scalping?[row]
        print("选中了: \(model?.banshees ?? "")")
    }
}
