//
//  FrontView.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/10.
//

import UIKit
import SnapKit

class FrontView: BaseView {
    
    private var data: [String] = []
    private var collectionViewHeightConstraint: Constraint?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "fr_tw_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "fr_cover_image")
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "fr_whi_image")
        return threeImageView
    }()
    
    lazy var appNamelabel: UILabel = {
        let appNamelabel = UILabel()
        appNamelabel.textColor = UIColor.init(hexString: "#FFFFFF")
        appNamelabel.textAlignment = .left
        appNamelabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        return appNamelabel
    }()
    
    lazy var morelabel: UILabel = {
        let morelabel = UILabel()
        morelabel.text = "More Products"
        morelabel.textColor = UIColor.init(hexString: "#1C2123")
        morelabel.textAlignment = .left
        morelabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(500))
        return morelabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 12, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneImageView)
        addSubview(twoImageView)
        addSubview(scrollView)
        addSubview(appNamelabel)
        scrollView.addSubview(threeImageView)
        scrollView.addSubview(morelabel)
        scrollView.addSubview(collectionView)
        
        oneImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: screen_width, height: 252))
        }
        twoImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: screen_width, height: 433))
        }
        
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        appNamelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(20)
        }
        
        threeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 219))
        }
        morelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.top.equalTo(threeImageView.snp.bottom).offset(13)
        }
        
        setupData()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData() {
        // 模拟数据
        data = (1...20).map { "Item \($0)" }
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(morelabel.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.width.equalTo(scrollView)
            make.bottom.equalToSuperview().offset(-safeAreaInsets.bottom)
            self.collectionViewHeightConstraint = make.height.equalTo(0).constraint
        }
        
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let itemCount = data.count
        let numberOfRows = ceil(CGFloat(itemCount) / 2.0)
        
        let totalHorizontalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let availableWidth = collectionView.frame.width - totalHorizontalSpacing
        
        let cellHeight: CGFloat = 122
        
        let totalVerticalSpacing = layout.sectionInset.top + layout.sectionInset.bottom +
                                  (layout.minimumLineSpacing * (numberOfRows - 1))
        let totalHeight = (cellHeight * numberOfRows) + totalVerticalSpacing
        
        collectionViewHeightConstraint?.update(offset: totalHeight)
        
        layoutIfNeeded()
    }
    
}

// MARK: - UICollectionView DataSource & Delegate
extension FrontView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.configure(with: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 100, height: 100)
        }
        
        let totalHorizontalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let availableWidth = collectionView.frame.width - totalHorizontalSpacing
        let cellWidth = floor(availableWidth / 2)
        
        return CGSize(width: cellWidth, height: 120)
    }
}

// MARK: - Custom CollectionView Cell
class ItemCell: UICollectionViewCell {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "small_li_imge")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var smallImageView: UIImageView = {
        let smallImageView = UIImageView()
        smallImageView.image = UIImage(named: "small_co_l_image")
        smallImageView.isUserInteractionEnabled = true
        return smallImageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkText
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(smallImageView)
        bgImageView.addSubview(titleLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        smallImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(94)
        }
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}
