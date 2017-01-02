//
//  AddingTrainingDataState.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

final class AddingTrainingDataState {
    weak var delegate: StateDelegate?
    weak var stateChanger: StateChanging?
}

extension AddingTrainingDataState: State {
    func add(trainingData: Classifier.TrainingData) {
        delegate?.state(self, addTrainingData: trainingData)
    }

    func trainClassifier() {
        guard delegate?.stateWillTrainClassifier(self) ?? false else {
            return
        }
        
        delegate?.stateTrainClassifier(self)

        stateChanger?.changeToPredictingWorkingOut()
    }
}
