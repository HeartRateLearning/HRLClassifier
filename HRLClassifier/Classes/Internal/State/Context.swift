//
//  Context.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

final class Context {
    weak var delegate: ContextDelegate?

    fileprivate var state: State {
        didSet {
            state.delegate = self
            state.stateChanger = self
        }
    }

    init() {
        state = AddingTrainingDataState()

        // 'didSet' is only called when the property’s value
        // is set outside of an initialization context
        state.delegate = self
        state.stateChanger = self
    }

    func add(trainingData: Classifier.TrainingData) {
        state.add(trainingData: trainingData)
    }

    func trainClassifier() {
        state.trainClassifier()
    }

    func predictedWorkingOut(for record:Record) -> WorkingOut {
        return state.predictedWorkingOut(for: record)
    }

    func rollbackClassifider() {
        state.rollbackClassifider()
    }
}

extension Context: StateChanging {
    func changeToAddingTrainingData() {
        state = AddingTrainingDataState()
    }

    func changeToPredictingWorkingOut() {
        state = PredictingWorkingOutState()
    }
}

extension Context: StateDelegate {
    func state(_ state: State, addTrainingData trainingData: Classifier.TrainingData) {
        delegate?.context(self, addTrainingData: trainingData)
    }

    func stateWillTrainClassifier(_ state: State) -> Bool {
        guard let willTrain = delegate?.contextWillTrainClassifier(self) else {
            return false
        }

        return willTrain
    }

    func stateTrainClassifier(_ state: State) {
        delegate?.contextTrainClassifier(self)
    }

    func state(_ state: State, predictWorkingOutForRecord record: Record) -> WorkingOut {
        guard let prediction = delegate?.context(self, predictWorkingOutForRecord: record) else {
            return .unknown
        }

        return prediction
    }

    func stateRollbackClassifier(_ state: State) {
        delegate?.contextRollbackClassifier(self)
    }
}
