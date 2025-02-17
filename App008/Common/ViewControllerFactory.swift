//
//  ViewControllerFactory.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation
import Swinject
import App008Model
import App008ViewModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: Home
    static func makeHomeViewController() -> HomeViewController {
        let assembler = Assembler(commonAssemblies + [HomeAssembly()])
        let viewController = HomeViewController()
        viewController.viewModel = assembler.resolver.resolve(IHomeViewModel.self)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    //MARK: About
    static func makeAboutViewController() -> AboutViewController {
        let assembler = Assembler(commonAssemblies + [AboutAssembly()])
        let viewController = AboutViewController()
        viewController.viewModel = assembler.resolver.resolve(IAboutViewModel.self)
        return viewController
    }
//
//    //MARK: PrivacyPolicy
//    static func makePrivacyViewController() -> PrivacyViewController {
//        let viewController = PrivacyViewController()
//        return viewController
//    }
//
//    //MARK: Terms
//    static func makeTermsViewController() -> TermsViewController {
//        let viewController = TermsViewController()
//        return viewController
//    }

}
