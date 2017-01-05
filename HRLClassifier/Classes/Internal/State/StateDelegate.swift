//
//  StateDelegate.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//
//

import Foundation

/// Defines all possible events or requests a `State` might trigger.
/// Notice that it is a Class-Only Protocol, a struct would be copied on assigment to
/// a property.
protocol StateDelegate: class {
    /**
        Ask delegate to add training data to the `Classifier`.

        - Parameters:
            - state: state that triggered the event.
            - trainingData: data to add.
     */
    func state(_ state: State, addTrainingData trainingData: Classifier.TrainingData)

    /**
        Tells the delegate that the `Classifier` is about to be trained.

        - Parameter state: state that triggered the event.
     
        - Returns: `true` if the `Classifier` can be trained.
     */
    func stateWillTrainClassifier(_ state: State) -> Bool

    /**
        Ask delegate to train the `Classifier`.

        - Parameter state: state that triggered the event.
     */
    func stateTrainClassifier(_ state: State)

    /**
        Tells the delegate that the `Classifier` is about to be deployed.

        - Parameter state: state that triggered the event.
     
        - Returns: `true` if the `Classifier` can be deployed.
     */
    func stateWillDeployClassifier(_ state: State) -> Bool

    /**
        Ask delegate to get a prediction.

        - Parameters:
            - state: state that triggered the event.
            - record: a `Record` instance.
     
        - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    func state(_ state: State, predictWorkingOutForRecord record: Record) -> WorkingOut
}
