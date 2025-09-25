//
//  FrontView.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/10.
//

import UIKit
import SnapKit

class FrontView: BaseView {
    
    var headBlock: ((Int) -> Void)?
    
    var smallProductArray: [disgaveledModel]? {
        didSet {
            collectionView.reloadData()
            updateCollectionViewHeight()
        }
    }
    
    var headProductArray: [disgaveledModel]? {
        didSet {
            guard let headProductArray = headProductArray, let model = headProductArray.first else { return }
            productImageView.kf.setImage(with: URL(string: model.crackrope ?? ""))
            appNamelabel.text = model.saxcornet ?? ""
            desclabel.text = model.arrode ?? ""
            moneylabel.text = model.photoelectron ?? ""
            oneView.desclabel.text = model.fleuret ?? ""
            twoView.desclabel.text = model.unresourcefulness ?? ""
            applyBtn.setTitle(model.consuelo ?? "", for: .normal)
        }
    }
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            let buoyedModelArray = model.ande?.buoyed ?? []
            for model in buoyedModelArray {
                if model.derailer == "Daneflower" {
                    smallProductArray = model.disgaveled ?? []
                }else if model.derailer == "agaricaceae" {
                    headProductArray = model.disgaveled ?? []
                }
            }
        }
    }
    
    private var collectionViewHeightConstraint: Constraint?
    
    // MARK: - UI
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "fr_tw_image")
        oneImageView.isUserInteractionEnabled = true
        return oneImageView
    }()
    
    private lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "fr_cover_image")
        twoImageView.isUserInteractionEnabled = true
        return twoImageView
    }()
    
    private lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "fr_whi_image")
        threeImageView.isUserInteractionEnabled = true
        return threeImageView
    }()
    
    private lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        return productImageView
    }()
    
    private lazy var appNamelabel: UILabel = {
        let appNamelabel = UILabel()
        appNamelabel.textColor = UIColor(hexString: "#FFFFFF")
        appNamelabel.textAlignment = .left
        appNamelabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(700))
        return appNamelabel
    }()
    
    private lazy var morelabel: UILabel = {
        let morelabel = UILabel()
        morelabel.text = "More Products"
        morelabel.textColor = UIColor(hexString: "#1C2123")
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
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.textColor = UIColor.init(hexString: "#999B9C")
        desclabel.textAlignment = .left
        desclabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        return desclabel
    }()
    
    lazy var moneylabel: UILabel = {
        let moneylabel = UILabel()
        moneylabel.textColor = UIColor.init(hexString: "#1C2123")
        moneylabel.textAlignment = .left
        moneylabel.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(800))
        return moneylabel
    }()
    
    lazy var oneView: RateView = {
        let oneView = RateView()
        oneView.logoImageView.image = UIImage(named: "rate_list_image")
        return oneView
    }()
    
    lazy var twoView: RateView = {
        let twoView = RateView()
        twoView.logoImageView.image = UIImage(named: "rae_li_image")
        return twoView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitle("Obtain loan amount", for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.backgroundColor = UIColor.init(hexString: "#0073E5")
        applyBtn.layer.cornerRadius = 27
        applyBtn.layer.masksToBounds = true
        return applyBtn
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(oneImageView)
        addSubview(twoImageView)
        addSubview(scrollView)
        addSubview(productImageView)
        addSubview(appNamelabel)
        scrollView.addSubview(contentView)
        contentView.addSubview(threeImageView)
        contentView.addSubview(morelabel)
        contentView.addSubview(collectionView)
        
        threeImageView.addSubview(desclabel)
        threeImageView.addSubview(moneylabel)
        threeImageView.addSubview(oneView)
        threeImageView.addSubview(twoView)
        threeImageView.addSubview(applyBtn)
        
        oneImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: screen_width, height: 252))
        }
        twoImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: screen_width, height: 433))
        }
        productImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        appNamelabel.snp.makeConstraints { make in
            make.centerY.equalTo(productImageView.snp.centerY)
            make.left.equalTo(productImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        // scrollView & contentView
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        threeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(95)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 219))
        }
        
        desclabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(17)
        }
        moneylabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(desclabel.snp.bottom).offset(6)
            make.height.equalTo(44)
        }
        oneView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(moneylabel.snp.bottom).offset(12)
            make.height.equalTo(26)
            make.width.equalTo(110)
        }
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(20)
            make.top.equalTo(moneylabel.snp.bottom).offset(12)
            make.height.equalTo(26)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoView.snp.bottom).offset(24)
            make.size.equalTo(CGSize(width: 295, height: 54))
        }
        
        // "More Products"
        morelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.top.equalTo(threeImageView.snp.bottom).offset(13)
        }
        
        // CollectionView
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(morelabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            self.collectionViewHeightConstraint = make.height.equalTo(0).constraint
        }
        
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if let model = headProductArray?.first {
                self.headBlock?(model.amps ?? 0)
            }
        }).disposed(by: disposeBag)
        
        threeImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if let model = headProductArray?.first {
                self.headBlock?(model.amps ?? 0)
            }
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update Height
    private func updateCollectionViewHeight() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let itemCount = smallProductArray?.count ?? 0
        let numberOfRows = ceil(CGFloat(itemCount) / 2.0)
        
        let cellHeight: CGFloat = 122
        let totalVerticalSpacing = layout.sectionInset.top + layout.sectionInset.bottom +
        (layout.minimumLineSpacing * max(numberOfRows - 1, 0))
        let totalHeight = (cellHeight * numberOfRows) + totalVerticalSpacing
        
        collectionViewHeightConstraint?.update(offset: totalHeight)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-safeAreaInsets.bottom)
        }
    }
    
}

// MARK: - UICollectionView DataSource & Delegate
extension FrontView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallProductArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell",
                                                      for: indexPath) as! ItemCell
        let model = smallProductArray?[indexPath.item]
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 100, height: 100)
        }
        let totalHorizontalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let availableWidth = collectionView.frame.width - totalHorizontalSpacing
        let cellWidth = floor(availableWidth / 2)
        return CGSize(width: cellWidth, height: 122)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = smallProductArray?[indexPath.item]
        let productID = model?.amps ?? 0
        self.headBlock?(productID)
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
    
    lazy var nameView: SmallNameView = {
        let nameView = SmallNameView()
        nameView.logoImageView.image = UIImage(named: "center_logo_image")
        return nameView
    }()
    
    lazy var applyImageView: UIImageView = {
        let applyImageView = UIImageView()
        applyImageView.image = UIImage(named: "apply_lad_image")
        applyImageView.isUserInteractionEnabled = true
        return applyImageView
    }()
    
    lazy var desclabel: UILabel = {
        let desclabel = UILabel()
        desclabel.textColor = UIColor.init(hexString: "#98B4CF")
        desclabel.textAlignment = .center
        desclabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return desclabel
    }()
    
    lazy var moneylabel: UILabel = {
        let moneylabel = UILabel()
        moneylabel.textColor = UIColor.init(hexString: "#1C2123")
        moneylabel.textAlignment = .center
        moneylabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(800))
        return moneylabel
    }()
    
    lazy var applabel: UILabel = {
        let applabel = UILabel()
        applabel.textColor = UIColor.init(hexString: "#865000")
        applabel.textAlignment = .center
        applabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return applabel
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
        bgImageView.addSubview(nameView)
        bgImageView.addSubview(applyImageView)
        smallImageView.addSubview(desclabel)
        smallImageView.addSubview(moneylabel)
        applyImageView.addSubview(applabel)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        smallImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(94)
        }
        nameView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(smallImageView.snp.top)
        }
        applyImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-6)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 148, height: 32))
        }
        desclabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(9)
            make.height.equalTo(15)
        }
        moneylabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(desclabel.snp.bottom)
            make.height.equalTo(20)
        }
        applabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var model: disgaveledModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.crackrope ?? ""
            self.nameView.logoImageView.kf.setImage(with: URL(string: logoUrl))
            self.nameView.desclabel.text = model.saxcornet ?? ""
            self.desclabel.text = model.arrode ?? ""
            self.moneylabel.text = model.photoelectron ?? ""
            self.applabel.text = model.consuelo ?? ""
        }
    }
}
