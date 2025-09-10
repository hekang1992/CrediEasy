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
        scrollView.backgroundColor = UIColor.init(hexString: "#D9D9D9")
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
        return applyImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(headImageView)
        scrollView.addSubview(applyImageView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
