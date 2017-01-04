//
//  Context.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

/// This class control the `State` of the `Classifier`, do not reference the `State`
/// instances directly, use this class instead.
/// Notice that this is a Class-Only Protocol because *copying or comparing
/// instances doesn't make sense*.
protocol ContextProtocol: class {
    weak var delegate: ContextDelegate? { get set }

    /**
        Add data that will be used to train the `Classifier`.

        - Parameter trainingData: data to add.
     */
    func add(trainingData: Classifier.TrainingData)

    /// Train the `Classifier` with the trainig data provided before.
    func trainClassifier()

    /**
        Return a prediction.

        - Parameter record: a `Record` instance.

        - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    func predictedWorkingOut(for record:Record) -> WorkingOut

    /// Disable predictions, more training data can be added to the `Classifier`.
    func rollbackClassifier()
}

/// Implementation of `ContextProtocol`.
final class Context {
    weak var delegate: ContextDelegate?

    fileprivate var state: State {
        didSet {
            state.delegate = self
            state.stateChanger = self
        }
    }

    /**
        Initializes a new `Context`.

        - Returns: a new `Context`.
     */
    init() {
        state = AddingTrainingDataState()

        // 'didSet' is only called when the property’s value
        // is set outside of an initialization context
        state.delegate = self
        state.stateChanger = self
    }
}

extension Context: ContextProtocol {
    func add(trainingData: Classifier.TrainingData) {
        state.add(trainingData: trainingData)
    }

    func trainClassifier() {
        state.trainClassifier()
    }

    func predictedWorkingOut(for record:Record) -> WorkingOut {
        return state.predictedWorkingOut(for: record)
    }

    func rollbackClassifier() {
        state.rollbackClassifier()
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
}
