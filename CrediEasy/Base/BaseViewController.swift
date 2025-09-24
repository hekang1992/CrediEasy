//
//  BaseViewController.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/9.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView(frame: .zero)
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func popToSpecificViewController() {
        guard let navigationController = self.navigationController else { return }
        if let targetVC = navigationController.viewControllers.first(where: { $0 is AppStepViewViewController }) {
            navigationController.popToViewController(targetVC, animated: true)
        } else {
            navigationController.popViewController(animated: true)
        }
    }
    
}
