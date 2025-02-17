//
//  HomeViewModel.swift
//  App008ViewModel
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation
import App008Model

public protocol IHomeViewModel {

}

public class HomeViewModel: IHomeViewModel {

    private let homeService: IHomeService

    public init(homeService: IHomeService) {
        self.homeService = homeService
    }
}
