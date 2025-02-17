//
//  OnboardingService.swift
//  App008ViewModel
//
//  Created by Er Baghdasaryan on 17.02.25.
//


import UIKit
import App008Model

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "onboarding1",
                                        buttonText: "NEXT"),
            OnboardingPresentationModel(image: "onboarding2",
                                        buttonText: "LETS GO")
        ]
    }
}
