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

    private let context: Context

    fileprivate let dataFrame: DataFrame
    fileprivate let classifier: HRLKNNClassifier

    /**
        Initializes a new `Classifier`.
     
        - Returns: a new `Classifier`.
     */
    public init() {
        context = Context()
        dataFrame = DataFrame()
        classifier = HRLKNNClassifier()

        context.delegate = self
    }

    /**
        Add data that will be used to train the `Classifier`.
     
        - Parameter trainingData: data to add.
     */
    public func add(trainingData: TrainingData) {
        context.add(trainingData: trainingData)
    }

    /**
        After adding the training data, call this method to train the `Classifier`
        in order to prepare it to make predictions.
     */
    public func train() {
        context.trainClassifier()
    }

    /**
        Once the `Classifier` is trained, use this method to make predictions.

        - Parameter record: a `Record` instance.
     
        - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    public func predictedWorkingOut(for record:Record) -> WorkingOut {
        return context.predictedWorkingOut(for: record)
    }
}

extension Classifier: ContextDelegate {
    func context(_ context: Context, addTrainingData trainingData: Classifier.TrainingData) {
        dataFrame.append(record: trainingData.record, isWorkingOut: trainingData.isWorkingOut)
    }

    func contextWillTrainClassifier(_ context: Context) -> Bool {
        return true
    }

    func contextTrainClassifier(_ context: Context) {
        let matrix = HRLMatrix()
        matrix.fill(with: dataFrame)

        classifier.train(with: matrix)
    }

    func context(_ context: Context, predictWorkingOutForRecord record: Record) -> WorkingOut {
        let predictedClass = classifier.predictClass(for: record)

        return WorkingOut(rawValue: predictedClass)!
    }
}
