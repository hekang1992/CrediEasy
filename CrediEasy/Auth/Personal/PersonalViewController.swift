//
//  PersonalViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit

class PersonalViewController: BaseViewController {
    
    var productID: String = ""
    
    var pagetitle: String = ""
    
    let viewModel = PersonalViewModel()
    
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
            stepView.setCurrentIndex(1, animated: false)
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
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-10)
        }
        
        viewModel.getPersonalInfo(with: productID) { model in
            self.model = model
            self.tableView.reloadData()
        }
    }

}

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.ande?.revolutionised?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.model?.ande?.revolutionised?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClickTextCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
}
