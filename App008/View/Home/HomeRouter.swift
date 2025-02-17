//
//  HomeRouter.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation
import UIKit
import App008ViewModel

final class HomeRouter: BaseRouter {
    static func showSettingsViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeSettingsViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
