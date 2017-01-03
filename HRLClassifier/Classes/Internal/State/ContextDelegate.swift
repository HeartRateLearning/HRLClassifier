//
//  ContextDelegate.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//
//

import Foundation

/// Defines all possible events or requests a `Context` might trigger.
/// Notice that it is a Class-Only Protocol, a struct would be copied on assigment to
/// a property.
protocol ContextDelegate: class {
    /**
        Ask delegate to add training data to the `Classifier`.

        - Parameters:
            - context: context that triggered the event.
            - trainingData: data to add.
     */
    func context(_ context: Context, addTrainingData trainingData: Classifier.TrainingData)

    /**
        Tells the delegate that the `Classifier` is about to be trained.

        - Parameter context: context that triggered the event.

        - Returns: `true` if the `Classifier` can be trained.
     */
    func contextWillTrainClassifier(_ context: Context) -> Bool

    /**
        Ask delegate to train the `Classifier`.

        - Parameter context: context that triggered the event.
     */
    func contextTrainClassifier(_ context: Context)

    /**
        Ask delegate to get a prediction.

        - Parameters:
            - context: context that triggered the event.
            - record: a `Record` instance.

     - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    func context(_ context: Context, predictWorkingOutForRecord record: Record) -> WorkingOut
}
