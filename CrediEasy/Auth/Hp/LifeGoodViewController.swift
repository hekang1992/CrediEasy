//
//  PersonalViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit
import TYAlertController
import RxSwift

class LifeGoodViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    
    var pagetitle: String = ""
    
    let viewModel = LifeGoodViewModel()
    
    var model: BaseModel?
    
    lazy var stepView: StepView = {
        let stepView = StepView()
        return stepView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView(frame: .zero)
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 25
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        nextBtn.layer.cornerRadius = 27
        nextBtn.layer.masksToBounds = true
        return nextBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(hexString: "#F2F8FC")
        tableView.register(InputTextCell.self, forCellReuseIdentifier: "InputTextCell")
        tableView.register(ClickTextCell.self, forCellReuseIdentifier: "ClickTextCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#0073E5")
        view.addSubview(headView)
        headView.namelabel.text = pagetitle
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            popToSpecificViewController()
        }).disposed(by: disposeBag)
        
        view.addSubview(stepView)
        stepView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(19)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        viewModel.getProductDetaiInfo(productID: productID)
        
        viewModel.detailModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            stepView.modelArray = model.ande?.beakful ?? []
            stepView.setCurrentIndex(2, animated: false)
        }).disposed(by: disposeBag)
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.bottom).offset(26)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(20)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }
        
        whiteView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-10)
        }
        
        viewModel.getPersonalInfo(with: productID) { model in
            self.model = model
            self.tableView.reloadData()
        }
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let modelArray = self.model?.ande?.revolutionised else { return }
            var dict = ["fuckups": productID]
            modelArray.forEach { model in
                guard let key = model.larcenable else { return }
                if model.ranivorous == "Munday" {
                    let derailer = model.derailer ?? 0
                    derailer == 0 ? (dict[key] = "") : (dict[key] = String(derailer))
                } else {
                    dict[key] = model.whens ?? ""
                }
            }
            safeInfo(with: dict)
        }).disposed(by: disposeBag)
        
    }
    
    private func safeInfo(with dict: [String: Any]) {
        viewModel.safePersonalInfo(wit: dict) { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.popToSpecificViewController()
            }
            ToastShowMessage.showToast(message: model.hypsodonty ?? "")
        }
    }

}

extension LifeGoodViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.ande?.revolutionised?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.model?.ande?.revolutionised?[indexPath.row]
        let ranivorous = model?.ranivorous ?? ""
        if ranivorous == "seriosities" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextCell", for: indexPath) as! InputTextCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.authModel = model
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClickTextCell", for: indexPath) as! ClickTextCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.authModel = model
            cell.clickBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self, let model = model else { return }
                cellClickModel(with: model, cell: cell)
            }).disposed(by: disposeBag)
            return cell
        }
    }
    
    private func cellClickModel(with model: revolutionisedModel, cell: ClickTextCell) {
        self.view.endEditing(true)
        let ranivorous = model.ranivorous ?? ""
        if ranivorous == "Munday" {
            let popEnumView = PopEnmuView(frame: self.view.frame)
            popEnumView.model = model
            let alertVc = TYAlertController(alert: popEnumView, preferredStyle: .actionSheet)!
            self.present(alertVc, animated: true)
            popEnumView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
            
            popEnumView.sureBlock = { index in
                self.dismiss(animated: true) {
                    cell.phoneTx.text = model.scalping?[index].banshees ?? ""
                    cell.authModel?.derailer = model.scalping?[index].derailer ?? 0
                }
            }
        }else {
            let popCityView = PopCityView(frame: self.view.frame)
            popCityView.model = CityInfoModel.shared.cityModel
            let alertVc = TYAlertController(alert: popCityView, preferredStyle: .actionSheet)!
            self.present(alertVc, animated: true)
            popCityView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
            
            popCityView.sureBlock = { city in
                self.dismiss(animated: true) {
                    cell.phoneTx.text = city
                    cell.authModel?.whens = city
                }
            }
        }
    }
    
}
