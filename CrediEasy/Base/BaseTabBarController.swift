//
//  BaseTabBarController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // 创建三个视图控制器
        let homeVC = createNavController(viewController: HomeViewController(), title: "Home", imageName: "home_nor", selectedImageName: "home_sel")
        let orderVC = createNavController(viewController: OrderViewController(), title: "Order", imageName: "order_nor", selectedImageName: "order_sel")
        let profileVC = createNavController(viewController: ProfileViewController(), title: "Center", imageName: "center_nor", selectedImageName: "center_sel")
        
        viewControllers = [homeVC, orderVC, profileVC]
        
        setupTabBarAppearance()
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String, selectedImageName: String) -> UINavigationController {
        
        let navController = BaseNavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        
        navController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        
        viewController.title = title
        
        return navController
    }
    
    private func setupTabBarAppearance() {
        tabBar.tintColor = .systemBlue
        
        tabBar.unselectedItemTintColor = .gray
        
        tabBar.backgroundColor = .white
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到: \(viewController.title ?? "未知")")
        return true // 返回true允许切换，返回false阻止切换
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("已切换到: \(viewController.title ?? "未知")")
        
        if let navController = viewController as? UINavigationController {
            if let _ = navController.topViewController as? HomeViewController {
                print("首页被点击")
            } else if let _ = navController.topViewController as? OrderViewController {
                print("订单被点击")
            } else if let _ = navController.topViewController as? ProfileViewController {
                print("个人中心被点击")
            }
        }
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        if hexFormatted.hasPrefix("0X") {
            hexFormatted = String(hexFormatted.dropFirst(2))
        }
        
        var hexValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&hexValue)
        
        self.init(hex: UInt32(hexValue), alpha: alpha)
    }
}
