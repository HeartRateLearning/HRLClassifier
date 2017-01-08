//
//  Classifier.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 22/12/2016.
//
//

import Foundation
import HRLAlgorithms

/// A class that conforms to `ClassifierProtocol` is able to predict if
/// a person is working out or not based on the information provided in 
/// a `Record`.
public protocol ClassifierProtocol {
    /**
        Use this method to make predictions.

        - Parameter record: A `Record` instance.

        - Returns: `true` if the `Classifier` estimates the user was working out.
     */
    func predictedWorkingOut(for record: Record) -> Bool
}

/// Implementation of protocol: `ClassifierProtocol`
final class Classifier {
    fileprivate let trainedKNNClassifier: HRLTrainedKNNClassifier

    /**
        Initializes a `Classifier`.
     
        - Parameter trainedKNNClassifier: K-NN classifier provided by `HRLAlgorithms`.
     
        - Returns: A new `Classifeir`.
     */
    init(trainedKNNClassifier: HRLTrainedKNNClassifier) {
        self.trainedKNNClassifier = trainedKNNClassifier
    }
}

extension Classifier: ClassifierProtocol {
    func predictedWorkingOut(for record: Record) -> Bool {
        let predictedClass = trainedKNNClassifier.predictedClass(for: record)
        let workingOut = WorkingOut(rawValue: predictedClass)!

        return Bool(workingOut)!
    }
}
