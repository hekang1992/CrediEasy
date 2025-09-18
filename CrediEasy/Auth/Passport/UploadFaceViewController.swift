//
//  UploadFaceViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit
import TYAlertController
import RxSwift

class UploadFaceViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = PassportViewModel()
    
    var type: String = ""
    
    var productID: String = ""
    
    var photoBool: Int = 0
    
    var faceBool: Int = 0
    
    let photoLibraryManager = PhotoLibraryManager()
    
    let cameraManager = CameraManager()
    
    var isShowPhotoAlert: Bool = false
    
    var isShowFaceAlert: Bool = false
    
    var enterPhototime: String = ""
    var enterCameratime: String = ""
    
    let pointViewModel = PointViewModel()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView(frame: .zero)
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 25
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var stepView: StepView = {
        let stepView = StepView()
        return stepView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(hexString: "#1C2123")
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.text = "Identity verification, embark on your journey of security"
        descLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(800))
        return descLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#E9F2F9")
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var changeImageView: UIImageView = {
        let changeImageView = UIImageView()
        changeImageView.image = UIImage(named: "change_umid_image")
        return changeImageView
    }()
    
    lazy var cardLabel: UILabel = {
        let cardLabel = UILabel()
        cardLabel.textColor = UIColor.init(hexString: "#0073E5")
        cardLabel.textAlignment = .left
        cardLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return cardLabel
    }()
    
    lazy var changeLabel: UILabel = {
        let changeLabel = UILabel()
        changeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        changeLabel.textAlignment = .center
        changeLabel.text = "Switch"
        changeLabel.layer.cornerRadius = 20
        changeLabel.layer.masksToBounds = true
        changeLabel.backgroundColor = UIColor.init(hexString: "#0073E5")
        changeLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return changeLabel
    }()
    
    lazy var photoView: ImageListView = {
        let photoView = ImageListView()
        photoView.cardLabel.text = "Upload your ID card"
        photoView.descImageView.image = UIImage(named: "ss_list_image")
        return photoView
    }()
    
    lazy var faceView: ImageListView = {
        let faceView = ImageListView()
        faceView.cardLabel.text = "Facial recognitbon"
        faceView.descImageView.image = UIImage(named: "face_list_id_image")
        return faceView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#0073E5")
        view.addSubview(headView)
        headView.namelabel.text = "ldentity Authentication"
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        enterPhototime = String(Int(Date().timeIntervalSince1970))
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if photoBool == 0 {
                self.navigationController?.popViewController(animated: true)
            }else {
                popToSpecificViewController()
            }
        }).disposed(by: disposeBag)
        
        bgView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if photoBool == 0 {
                self.navigationController?.popViewController(animated: true)
            }else {
                ToastShowMessage.showToast(message: "You have successfully completed ID verification.")
            }
        }).disposed(by: disposeBag)
        
        view.addSubview(stepView)
        stepView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(19)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.bottom).offset(26)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(20)
        }
        
        viewModel.detailModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            stepView.modelArray = model.ande?.beakful ?? []
            stepView.setCurrentIndex(0, animated: false)
        }).disposed(by: disposeBag)
        
        whiteView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(315)
        }
        
        scrollView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 113))
            make.top.equalTo(descLabel.snp.bottom).offset(24)
        }
        
        scrollView.addSubview(changeImageView)
        changeImageView.snp.makeConstraints { make in
            make.right.equalTo(bgView.snp.right)
            make.bottom.equalTo(bgView.snp.bottom)
            make.size.equalTo(CGSize(width: 132, height: 125))
        }
        
        bgView.addSubview(cardLabel)
        cardLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(17)
        }
        cardLabel.text = "\(type) Card"
        
        bgView.addSubview(changeLabel)
        changeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 90, height: 42))
        }
        
        scrollView.addSubview(photoView)
        scrollView.addSubview(faceView)
        
        photoView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.width.equalTo(screen_width)
            make.height.equalTo(238)
        }
        faceView.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.width.equalTo(screen_width)
            make.height.equalTo(238)
        }
        
        scrollView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(faceView.snp.bottom).offset(23)
            make.size.equalTo(CGSize(width: 335, height: 54))
            make.bottom.equalToSuperview().offset(-40)
        }
        
        viewModel.idModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            photoBool = model.ande?.foxtrot?.ideist ?? 0
            faceBool = model.ande?.helotry?.ideist ?? 0
            if type.isEmpty {
                cardLabel.text = "\(model.ande?.foxtrot?.agynic ?? "") Card"
            }
            if photoBool == 0 {
                if isShowPhotoAlert == false {
                    popPhotoView()
                }
                photoView.gouImageView.isHidden = true
            }else {
                photoView.gouImageView.isHidden = false
                if faceBool == 0 {
                    faceView.gouImageView.isHidden = true
                    if isShowFaceAlert == false {
                        popFaceView()
                    }
                }else {
                    faceView.gouImageView.isHidden = false
                }
            }
            let photoUrl = model.ande?.foxtrot?.roguy ?? ""
            let faceUrl = model.ande?.helotry?.roguy ?? ""
            if !photoUrl.isEmpty {
                photoView.descImageView.kf.setImage(with: URL(string: photoUrl))
            }
            if !faceUrl.isEmpty {
                faceView.descImageView.kf.setImage(with: URL(string: faceUrl))
            }
        }).disposed(by: disposeBag)
        
        /// 上传照片成功
        viewModel.popPhotoModel.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            let successView = PopImageView(frame: self.view.frame)
            successView.modelArray = model.ande?.interspicular ?? []
            successView.tableView.reloadData()
            let alertVc = TYAlertController(alert: successView, preferredStyle: .actionSheet)!
            self.present(alertVc, animated: true)
            var time: String = ""
            successView.dateBlock = { [weak self] cell in
                guard let self = self else { return }
                let modelArray = model.ande?.interspicular ?? []
                for model in modelArray {
                    if model.larcenable == "phratry" {
                        let hydrophoria = model.hydrophoria ?? ""
                        if time.isEmpty {
                            time = hydrophoria.isEmpty ? "1999-10-30" : hydrophoria
                        }else {
                         time = time
                        }
                    }
                }
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    // 使用 window
                    let pickView = DatePickerView(frame: self.view.frame,
                                                  defaultDateString: time)
                    window.addSubview(pickView)
                    
                    pickView.onDateChanged = { date in
                        cell.phoneTx.text = date
                        time = date
                        for model in modelArray {
                            if model.larcenable == "phratry" {
                                model.hydrophoria = time
                            }
                        }
                    }
                    
                    pickView.cancelBtn.rx.tap.subscribe(onNext: {
                        pickView.removeFromSuperview()
                    }).disposed(by: disposeBag)
                    
                    pickView.sureBtn.rx.tap.subscribe(onNext: {
                        pickView.removeFromSuperview()
                    }).disposed(by: disposeBag)
                    
                }
                
            }
            
            successView.saveBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let modelArray = model.ande?.interspicular ?? []
                print("===========")
                var dict = ["derailer": "11", "agynic": type]
                for model in modelArray {
                    guard let key = model.larcenable else { continue }
                    let value = model.hydrophoria ?? ""
                    dict[key] = value
                }
                viewModel.safePhotoInfo(with: dict) { model in
                    if model.larcenable == "0" || model.larcenable == "00" {
                        self.dismiss(animated: true) {
                            self.viewModel.getIDetaiInfo(productID: self.productID)
                            self.pointViewModel.getMonesesInfo(with: "3", pergamos: self.enterPhototime, paludicoline: String(Int(Date().timeIntervalSince1970)))
                        }
                    }
                    ToastShowMessage.showToast(message: model.hypsodonty ?? "")
                }
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
        
        photoView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self, let model = viewModel.idModel.value else { return }
            photoBool = model.ande?.foxtrot?.ideist ?? 0
            faceBool = model.ande?.helotry?.ideist ?? 0
            if photoBool == 0 {
                popPhotoView()
            }else {
                ToastShowMessage.showToast(message: "You have successfully completed ID verification.")
            }
        }).disposed(by: disposeBag)
        
        faceView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self, let model = viewModel.idModel.value else { return }
            photoBool = model.ande?.foxtrot?.ideist ?? 0
            faceBool = model.ande?.helotry?.ideist ?? 0
            if photoBool == 0 {
                popPhotoView()
            }else {
                if faceBool == 0 {
                    popFaceView()
                }else {
                    ToastShowMessage.showToast(message: "You have successfully completed Face verification.")
                }
            }
        }).disposed(by: disposeBag)
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let model = viewModel.idModel.value else { return }
            photoBool = model.ande?.foxtrot?.ideist ?? 0
            faceBool = model.ande?.helotry?.ideist ?? 0
            if photoBool == 0 {
                popPhotoView()
            }else {
                if faceBool == 0 {
                    popFaceView()
                }else {
                    viewModel.getProductDetaiInfo(productID: productID, isTap: true)
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.getProductDetaiInfo(productID: productID)
        viewModel.getIDetaiInfo(productID: productID)
        
    }

}

extension UploadFaceViewController {
    
    private func popPhotoView() {
        isShowPhotoAlert = true
        let photoView = PopPhotoView(frame: self.view.frame)
        let alertVc = TYAlertController(alert: photoView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        photoView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        photoView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                self.photoLibraryManager.pickPhoto(from: self, allowsEditing: false) { [weak self] image, info in
                    guard let self = self, let image = image else { return }
                    self.handleSelectedImage(image: image, concordantly: 2)
                }
            }
        }).disposed(by: disposeBag)
        
        photoView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                self.enterCameratime = String(Int(Date().timeIntervalSince1970))
                self.cameraManager.takePhoto(from: self, allowsEditing: false) { [weak self] image, info in
                    guard let self = self, let image = image else { return }
                    self.handleSelectedImage(image: image, concordantly: 1)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    private func popFaceView() {
        isShowFaceAlert = true
        let faceView = PopFaceView(frame: self.view.frame)
        let alertVc = TYAlertController(alert: faceView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        faceView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        faceView.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                self.cameraManager.takePhoto(from: self, allowsEditing: true) { [weak self] image, info in
                    guard let self = self, let image = image else { return }
                    self.handleSelectedFaceImage(image: image)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    /// Photo
    private func handleSelectedImage(image: UIImage, concordantly: Int) {
        let dict = ["concordantly": concordantly,
                    "derailer": 11,
                    "agynic": type] as [String : Any]
        viewModel.upLoadPhotoImage(with: dict, image: image)
    }
    
    /// Face
    private func handleSelectedFaceImage(image: UIImage) {
        let dict = ["concordantly": 1,
                    "derailer": 10,
                    "agynic": type] as [String : Any]
        viewModel.upLoadFaceImage(with: dict, image: image, completion: { model in
            if model.larcenable == "0" || model.larcenable == "00" {
                self.popToSpecificViewController()
                self.pointViewModel.getMonesesInfo(with: "4", pergamos: self.enterCameratime, paludicoline: String(Int(Date().timeIntervalSince1970)))
            }
        })
    }
    
}

//let pickView = DatePickerView(defaultDateString: "09-09-2011")
//let alertVc = TYAlertController(alert: pickView, preferredStyle: .actionSheet)!
//self.present(alertVc, animated: true)
