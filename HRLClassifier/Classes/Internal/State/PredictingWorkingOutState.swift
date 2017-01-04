//
//  PredictingWorkingOutState.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

final class PredictingWorkingOutState {
    weak var delegate: StateDelegate?
    weak var stateChanger: StateChanging?
}

extension PredictingWorkingOutState: State {
    func calculatedClassificationAccuracy() -> Double {
        guard let accuracy = delegate?.stateCalculateClassificationAccuracy(self) else {
            return Double(0)
        }

        return accuracy
    }

    func predictedWorkingOut(for record:Record) -> WorkingOut {
        guard let prediction = delegate?.state(self, predictWorkingOutForRecord: record) else {
            return .unknown
        }

        return prediction
    }

    func rollbackClassifier() {
        stateChanger?.changeToAddingTrainingData()
    }
}
