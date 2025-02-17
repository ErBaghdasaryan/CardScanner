//
//  AboutViewModel.swift
//  App008ViewModel
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation
import ModelIO

public protocol IAboutViewModel {
}

public class AboutViewModel: IAboutViewModel {

    private let aboutService: IAboutService

    public init(aboutService: IAboutService) {
        self.aboutService = aboutService
    }
}
