//
//  SettingsViewModel.swift
//  App008ViewModel
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation
import App008Model

public protocol ISettingsViewModel {
    
}

public class SettingsViewModel: ISettingsViewModel {

    private let settingsService: ISettingsService

    public init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }
}
