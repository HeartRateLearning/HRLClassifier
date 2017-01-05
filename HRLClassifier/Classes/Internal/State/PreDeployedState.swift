//
//  PreDeployedState.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 04/01/2017.
//
//

import Foundation

final class PreDeployedState {
    weak var delegate: StateDelegate?
    weak var stateChanger: StateChanging?
}

extension PreDeployedState: State {
    func deployClassifier() {
        guard delegate?.stateWillDeployClassifier(self) ?? false else {
            return
        }

        stateChanger?.changeToPredictingWorkingOut()
    }

    func rollbackClassifier() {
        stateChanger?.changeToAddingTrainingData()
    }
}
