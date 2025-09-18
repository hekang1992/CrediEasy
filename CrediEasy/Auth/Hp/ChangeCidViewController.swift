//
//  ChangeCidViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/17.
//

import UIKit
import WebKit
import RxSwift

class ChangeCidViewController: BaseViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    var productID: String = ""
    var pagetitle: String = ""
    var pageUrl: String?
    
    // MARK: - UI Components
    
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadWebContent()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(hexString: "#0073E5")
        
        view.addSubview(headView)
        view.addSubview(webView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        headView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(10)
        }
    }
    
    private func setupBindings() {
        headView.backBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.popToSpecificViewController()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Web Content Loading
    
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
    }
}

// MARK: - WKNavigationDelegate & WKScriptMessageHandler

extension ChangeCidViewController: WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController,
                             didReceive message: WKScriptMessage) {
        // Handle script messages here
        print("Received message: \(message.name) - \(message.body)")
    }
    
    // Optional: Implement WKNavigationDelegate methods as needed
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("WebView started loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }
}
