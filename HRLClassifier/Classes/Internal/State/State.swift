//
//  State.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

/// This protocol defines the interface for any particular state.
/// Notice that this is a Class-Only Protocol because *copying or comparing
/// instances doesn't make sense*.
protocol State: class {
    /// Request actions or extra data to this delegate.
    weak var delegate: StateDelegate? { get set }

    /// Use this property to change to another state.
    weak var stateChanger: StateChanging? { get set }

    /**
        Add data that will be used to train the `Classifier`.

        - Parameter trainingData: data to add.
     */
    func add(trainingData: Classifier.TrainingData)

    /// Train the `Classifier`.
    func trainClassifier()

    /// Estimated accuracy of the `Classifier`
    func calculatedClassificationAccuracy() -> Double

    /**
        Use this method to make predictions.

        - Parameter record: A `Record` instance.

        - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    func predictedWorkingOut(for record:Record) -> WorkingOut

    /// Disable predictions, more training data can be added to the `Classifier`.
    func rollbackClassifier()
}

extension State {
    func add(trainingData: Classifier.TrainingData) {}

    func trainClassifier() {}

    func calculatedClassificationAccuracy() -> Double {
        return Double(0)
    }

    func predictedWorkingOut(for record:Record) -> WorkingOut {
        return .unknown
    }

    func rollbackClassifier() {}
}
