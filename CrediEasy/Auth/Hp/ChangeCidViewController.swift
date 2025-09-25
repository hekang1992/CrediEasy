//
//  ChangeCidViewController.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/17.
//

import UIKit
import WebKit
import RxSwift
import StoreKit

class ChangeCidViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    var pagetitle: String = ""
    var pageUrl: String?
    
    var entertime: String = ""
    
    let pointViewModel = PointViewModel()
    
    var orderNumber: String = ""
    
    var type: String = ""
        
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let scriptNames = [
            "Microgaster", "pluvialine", "subtenancy",
            "theatrize", "Alexio", "Strophius", "tradable"
        ]
        
        scriptNames.forEach {
            configuration.userContentController.add(self, name: $0)
        }
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.init(hexString: "#E51F89")
        progressView.trackTintColor = .lightGray
        return progressView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadWebContent()
        entertime = String(Int(Date().timeIntervalSince1970))
    }
        
    private func setupUI() {
        view.backgroundColor = UIColor(hexString: "#0073E5")
        
        view.addSubview(headView)
        view.addSubview(progressView)
        view.addSubview(webView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
            make.height.equalTo(2)
        }
        
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom)
        }
    }
    
    private func setupBindings() {
        headView.backBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if type == "O" {
                    self.navigationController?.popToRootViewController(animated: true)
                }else {
                    self.popToSpecificViewController()
                }
            })
            .disposed(by: disposeBag)
        
    }
        
    private func loadWebContent() {
        guard let pageUrl = pageUrl else { return }
        
        let parameters = APIQueryBuilder.getParameters()
        let encodedUrlString = pageUrl
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
            .replacingOccurrences(of: " ", with: "%20") ?? pageUrl
        
        guard let finalUrl = URLQueryBuilder.appendingQueryParameters(
            to: encodedUrlString,
            parameters: parameters
        ).flatMap(URL.init) else {
            print("Failed to create valid URL")
            return
        }
        
        webView.load(URLRequest(url: finalUrl))
        print("Loaded URL: \(finalUrl.absoluteString)")
        
        webView.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.headView.namelabel.text = title
                }
            }).disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .map { Float($0) }
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .filter { $0 == 1.0 }
            .subscribe(onNext: { [weak self] _ in
                self?.progressView.setProgress(0.0, animated: false)
                self?.progressView.isHidden = true
            })
            .disposed(by: disposeBag)
        
    }
}

extension ChangeCidViewController: WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController,
                             didReceive message: WKScriptMessage) {
        print("Received message: \(message.name) - \(message.body)")
        let messageName = message.name
        if messageName == "Microgaster" {
            self.popToSpecificViewController()
        }else if messageName == "Strophius" {
            entertime = String(Int(Date().timeIntervalSince1970))
        }else if messageName == "tradable" {
            pointViewModel.getMonesesInfo(with: "8", pergamos: entertime, paludicoline: String(Int(Date().timeIntervalSince1970)))
        }else if messageName == "Alexio" {
            pointViewModel.getMonesesInfo(with: "10", pergamos: entertime, paludicoline: String(Int(Date().timeIntervalSince1970)), milkiness: orderNumber)
        }else if messageName == "subtenancy" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
            }
        }else if messageName == "theatrize" {
            if #available(iOS 14.0, *), let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }else if messageName == "pluvialine" {
            
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("WebView started loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        print("WebView error")
    }
}
