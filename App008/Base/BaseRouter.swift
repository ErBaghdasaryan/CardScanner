//
//  BaseRouter.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import UIKit
import Combine
import App008ViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
