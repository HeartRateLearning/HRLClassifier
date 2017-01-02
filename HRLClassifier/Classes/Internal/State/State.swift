//
//  State.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

protocol State {
    weak var delegate: StateDelegate? { get set }
    weak var stateChanger: StateChanging? { get set }

    func add(trainingData: Classifier.TrainingData)
    func trainClassifier()
    func predictedWorkingOut(for record:Record) -> WorkingOut
    func rollbackClassifider()
}

extension State {
    func add(trainingData: Classifier.TrainingData) {}

    func trainClassifier() {}

    func predictedWorkingOut(for record:Record) -> WorkingOut {
        return .unknown
    }

    func rollbackClassifider() {}
}
