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
    private let classifier = HRLKNNClassifier()

    /**
        Initializes a new `Classifier`
     
        - Returns: a new `Classifier`
     */
    public init() {}

    /**
        In order to make predictions, you have to train the `Classifier` with this method.
     
        - Parameter dataFrame: A `DataFrame` instance
     */
    public func train(with dataFrame:DataFrame) {
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
