//
//  OnboardingRouter.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation
import UIKit
import App008ViewModel

final class OnboardingRouter: BaseRouter {
    static func showHomeViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeHomeViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
