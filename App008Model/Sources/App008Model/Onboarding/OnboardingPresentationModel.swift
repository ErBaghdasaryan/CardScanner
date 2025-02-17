//
//  OnboardingPresentationModel.swift
//  App008Model
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation

public struct OnboardingPresentationModel {
    public let image: String
    public let buttonText: String

    public init(image: String, buttonText: String) {
        self.image = image
        self.buttonText = buttonText
    }
}
