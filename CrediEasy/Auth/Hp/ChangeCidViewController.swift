//
//  ChangeCidViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/17.
//

import UIKit
import WebKit

class ChangeCidViewController: BaseViewController {
    
    var productID: String = ""
    
    var pagetitle: String = ""
    
    lazy var webView: WKWebView = {
        let userContentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        let scriptNames = ["rowanwood",
                           "sunflower",
                           "bisonHali",
                           "dogRutaba",
                           "houseWine",
                           "dinosaurJ"]
        scriptNames.forEach { userContentController.add(self, name: $0) }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    var pageUrl: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(1)
        }
        
        if let pageUrl = pageUrl {
            var webUrl = ""
            let para = APIQueryBuilder.getPera()
            let apiUrl = URLQueryBuilder.appendingQueryParameters(to: pageUrl, parameters: para) ?? ""
            webUrl = apiUrl.replacingOccurrences(of: " ", with: "%20")
            if let url = URL(string: webUrl) {
                webView.load(URLRequest(url: url))
            }
            print("webUrl========\(webUrl)")
        }
       
    }

}

extension ChangeCidViewController: WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    
}
