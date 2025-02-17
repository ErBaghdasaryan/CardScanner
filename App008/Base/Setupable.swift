//
//  Setupable.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
