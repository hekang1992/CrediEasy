//
//  AppDelegate.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import FBSDKCoreKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initRootVc()
        initWindow()
        initKeyBord()
        return true
    }
    
    
}


extension AppDelegate {
    
    func initWindow() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
    }
    
    func initRootVc() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeRootVc(_:)),
            name: NSNotification.Name("changeRootVc"),
            object: nil
        )
    }
    
    func initKeyBord() {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
    }
    
    @objc func changeRootVc(_ noti: Notification) {
        let model = FacebookModel.shared.facebookModel
        Settings.shared.appID = model?.abidances ?? ""
        Settings.shared.clientToken = model?.moonblink ?? ""
        Settings.shared.displayName = model?.commonalty ?? ""
        Settings.shared.appURLSchemeSuffix = model?.unknits ?? ""
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if AuthManager.shared.isLoggedIn {
                self.window?.rootViewController = BaseTabBarController()
            } else {
                self.window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
            }
        }
    }
    
}
