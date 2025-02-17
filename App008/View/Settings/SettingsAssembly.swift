//
//  SettingsAssembly.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation
import App008ViewModel
import Swinject
import SwinjectAutoregistration

final class SettingsAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ISettingsViewModel.self, initializer: SettingsViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ISettingsService.self, initializer: SettingsService.init)
    }
}
