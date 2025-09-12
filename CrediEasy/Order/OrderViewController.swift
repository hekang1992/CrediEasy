//
//  OrderViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit

class OrderViewController: BaseViewController {
    
    var type: String = "4"
    
    let viewModel = OrderViewModel()
    
    var modelArray: [buoyedModel] = []
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setImage(UIImage(named: "all_nor_image"), for: .normal)
        oneBtn.setImage(UIImage(named: "all_sel_image"), for: .selected)
        oneBtn.isSelected = true
        oneBtn.tag = 0
        oneBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "under_nor_image"), for: .normal)
        twoBtn.setImage(UIImage(named: "under_sel_image"), for: .selected)
        twoBtn.tag = 1
        twoBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var three: UIButton = {
        let three = UIButton(type: .custom)
        three.setImage(UIImage(named: "pay_nor_image"), for: .normal)
        three.setImage(UIImage(named: "pay_sel_image"), for: .selected)
        three.tag = 2
        three.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return three
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.setImage(UIImage(named: "finish_nor_image"), for: .normal)
        fourBtn.setImage(UIImage(named: "finish_sel_image"), for: .selected)
        fourBtn.tag = 3
        fourBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return fourBtn
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    var buttons: [UIButton] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(OrderViewCell.self,
                           forCellReuseIdentifier: "OrderViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.init(hexString: "#0073E5")
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.width.equalTo(screen_width)
            make.height.equalTo(44)
        }
        
        buttons = [oneBtn, twoBtn, three, fourBtn]
        
        scrollView.addSubview(oneBtn)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(three)
        scrollView.addSubview(fourBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 44))
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 44))
        }
        three.snp.makeConstraints { make in
            make.left.equalTo(twoBtn.snp.right)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 44))
        }
        fourBtn.snp.makeConstraints { make in
            make.left.equalTo(three.snp.right)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 94, height: 44))
            make.right.equalToSuperview().offset(-5)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-2)
        }
        
        viewModel.model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.modelArray = model.ande?.buoyed ?? []
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getOrderListInfo(type: type)
    }
    
}

extension OrderViewController {
    
    @objc func buttonTapped(_ sender: UIButton) {
        for button in buttons {
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 0:
            self.type = String(Int(3+1))
            viewModel.getOrderListInfo(type: type)
        case 1:
            self.type = String(Int(3+4))
            viewModel.getOrderListInfo(type: type)
        case 2:
            self.type = String(Int(3+3))
            viewModel.getOrderListInfo(type: type)
        case 3:
            self.type = String(Int(3+2))
            viewModel.getOrderListInfo(type: type)
        default:
            break
        }
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        let model = modelArray[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelArray[indexPath.row]
    }
    
}
