//
//  Classifier.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 22/12/2016.
//
//

import Foundation
import HRLAlgorithms

/// Train a `Classifier` with a `Dataframe` and then pass it a `Record`
/// to predict if a person was working out or not.
final public class Classifier {
    public typealias TrainingData = (record: Record, isWorkingOut: Bool)

    private let dataFrame = DataFrame()
    private let classifier = HRLKNNClassifier()

    /**
        Initializes a new `Classifier`
     
        - Returns: a new `Classifier`
     */
    public init() {}

    /**
        Add data that will be used to train the `Classifier`
     
        - Parameteres:
            - record: a `Record` instance
            - isWorkingOut: if the user was working out or not at the moment `record` was recorded
     */
    public func add(trainingData: TrainingData) {
        dataFrame.append(record: trainingData.record, isWorkingOut: trainingData.isWorkingOut)
    }

    /**
        After adding the training data, call this method to train the `Classifier`
        in order to prepare it to make predictions
     */
    public func train() {
        let matrix = HRLMatrix()
        matrix.fill(with: dataFrame)

        classifier.train(with: matrix)
    }

    /**
        Once the `Classifier` is trained, use this method to make predictions.

        - Parameter record: A `Record` instance
     
        - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    public func predictedWorkingOut(for record:Record) -> WorkingOut {
        let predictedClass = classifier.predictClass(for: record)

        return WorkingOut(rawValue: predictedClass)!
    }
}
