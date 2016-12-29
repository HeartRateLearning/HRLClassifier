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
public class Classifier {
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
    public func addTrainingData(record: Record, isWorkingOut: Bool) {
        dataFrame.append(record: record, isWorkingOut: isWorkingOut)
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
     
        - Returns: `true` is the `Classifier` estimates the user was working out.
     */
    public func predictedWorkingOut(for record:Record) -> Bool {
        let predictedClass = classifier.predictClass(for: record)
        let workingOut = WorkingOut(rawValue: predictedClass)!

        return Bool(workingOut)
    }
}
