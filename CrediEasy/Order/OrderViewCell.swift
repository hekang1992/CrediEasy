//
//  OrderViewCell.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/12.
//

import UIKit

class OrderViewCell: BaseViewCell {
    
    var model: buoyedModel? {
        didSet {
            guard let model = model else { return }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
