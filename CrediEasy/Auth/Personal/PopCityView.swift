//
//  PopEnmuView.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/17.
//

import UIKit

class PopCityView: BaseView {
    
    private var selectedProviceRow: Int = 0
    private var selectedCityRow: Int = 0
    private var selectedAeraRow: Int = 0
    
    var model: andeModel?
    
    var sureBlock: ((String) -> Void)?
    
    var cityInfoStr: String = ""
    
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
        headImageView.image = UIImage(named: "cho_citu_image")
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
            make.size.equalTo(CGSize(width: 156, height: 24))
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
            if cityInfoStr.isEmpty {
                let provinces = model?.buoyed?[0].banshees ?? ""
                let city = model?.buoyed?[0].buoyed?[0].banshees ?? ""
                let area = model?.buoyed?[0].buoyed?[0].buoyed?[0].banshees ?? ""
                cityInfoStr = "\(provinces)-\(city)-\(area)"
            }
            self.sureBlock?(cityInfoStr)
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PopCityView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let provinces = model?.buoyed else { return 0 }
        if component == 0 {
            return provinces.count
        }else if component == 1 {
            let cities = provinces[selectedProviceRow].buoyed
            return cities?.count ?? 0
        }else {
            let cities = provinces[selectedProviceRow].buoyed
            let areas = cities?[selectedCityRow].buoyed
            return areas?.count ?? 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        
        guard let provinces = model?.buoyed else { return containerView }
        
        switch component {
        case 0:
            let province = provinces[row]
            label.text = province.banshees ?? ""
            label.textColor = (row == selectedProviceRow) ? UIColor(hexString: "#0073E5") : .black
            
        case 1:
            let cities = provinces[selectedProviceRow].buoyed ?? []
            if row < cities.count {
                let city = cities[row]
                label.text = city.banshees ?? ""
                label.textColor = (row == selectedCityRow) ? UIColor(hexString: "#0073E5") : .black
            }
            
        case 2:
            let cities = provinces[selectedProviceRow].buoyed ?? []
            if selectedCityRow < cities.count {
                let areas = cities[selectedCityRow].buoyed ?? []
                if row < areas.count {
                    label.text = areas[row].banshees ?? ""
                    label.textColor = (row == selectedAeraRow) ? UIColor(hexString: "#0073E5") : .black
                }
            }
            
        default:
            break
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
        guard let provinces = model?.buoyed else { return }
        
        switch component {
        case 0:
            selectedProviceRow = row
            selectedCityRow = 0
            selectedAeraRow = 0
            pickerView.reloadComponent(0)
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        case 1:
            selectedCityRow = row
            selectedAeraRow = 0
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        case 2:
            selectedAeraRow = row
            pickerView.reloadComponent(2)
            
        default:
            break
        }
        
        let provinceName = provinces[selectedProviceRow].banshees ?? ""
        let cityName = provinces[selectedProviceRow].buoyed?[selectedCityRow].banshees ?? ""
        let areaName = provinces[selectedProviceRow].buoyed?[selectedCityRow].buoyed?[selectedAeraRow].banshees ?? ""
        
        cityInfoStr = "\(provinceName)-\(cityName)-\(areaName)"
    }

}
