//
//  LaunchViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import Combine

class LaunchViewController: BaseViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        getIDFAinfo()
        getInitAppInfo()
    }
    
}

extension LaunchViewController {
    
    private func getIDFAinfo() {
        IDFAManager.requestIDFA { authorized in
            print("IDFA=======: \(authorized ?? "")")
        }
    }
    
    private func getInitAppInfo() {
        let redimensioned = Locale.preferredLanguages.first ?? ""
        let energumenon = proxyEnabled.isProxyEnabled() ? 1 : 0
        let nitwitted = vpnConnected.isVPNConnected()
        let dict = ["redimensioned": redimensioned, "energumenon": energumenon, "nitwitted": nitwitted] as [String : Any]
        NetworkManager.shared.postForm(path: "/Sharpsburg/redimensioned", parameters: dict).sink { completion in
            if case .failure(let err) = completion {
                print("❌error====:", err)
            }
        } receiveValue: { model in
            print("✅success====:", model)
            if model.larcenable == "0" || model.larcenable == "00" {
                if let facebookModel = model.ande?.fifteenths {
                    FacebookModel.shared.facebookModel = facebookModel
                }
            }
            NotificationCenter.default.post(name: Notification.Name("changeRootVc"), object: nil)
        }.store(in: &cancellables)
        
    }
    
}


class FacebookModel{
    static let shared = FacebookModel()
    private init() {}
    var facebookModel: fifteenthsModel?
}

class proxyEnabled{
    static func isProxyEnabled() -> Bool {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any],
           let httpProxy = proxySettings[kCFNetworkProxiesHTTPEnable as String] as? NSNumber {
            return httpProxy.intValue == 1
        }
        return false
    }
}

class vpnConnected{
    static func isVPNConnected() -> Int {
        let cfDict = CFNetworkCopySystemProxySettings()
        guard let settings = cfDict?.takeRetainedValue() as? [String: Any] else {
            return 0
        }
        
        if let scopes = settings["__SCOPED__"] as? [String: Any] {
            for (key, _) in scopes {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") || key.contains("utun") {
                    return 1
                }
            }
        }
        return 0
    }
}
