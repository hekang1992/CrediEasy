//
//  SetpView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit

class StepView: BaseView {
    
    var modelArray: [beakfulModel]? {
        didSet {
            setupButtons()
        }
    }
    
    // 当前选中的索引
    var currentIndex: Int = 0 {
        didSet {
            updateButtonSelection()
        }
    }
    
    private var buttons: [UIButton] = []
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.alignment = .center
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupButtons() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        guard let models = modelArray, !models.isEmpty else { return }
        for (index, model) in models.enumerated() {
            let button = createButton(for: model, at: index)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(for model: beakfulModel, at index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "setp_\(index)_image"), for: .normal)
        button.setImage(UIImage(named: "setp_\(index)_selimage"), for: .selected)
        button.tag = index
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 47).isActive = true
        return button
    }
    
    private func updateButtonSelection() {
        for (index, button) in buttons.enumerated() {
            button.isSelected = (index <= currentIndex)
        }
    }
    
    func setCurrentIndex(_ index: Int, animated: Bool = false) {
        guard index >= 0 && index < buttons.count else { return }
        currentIndex = index
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        }
    }
    
}
