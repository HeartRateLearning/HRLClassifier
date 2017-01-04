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

    /// Constants
    enum Constants {
        /// Minimum number of records required for each day of the week
        /// before the `Classifier` can be trained
        static let minRecordsPerWeekday = 80
    }

    private let context: ContextProtocol

    fileprivate let dataFrame: DataFrameProtocol
    fileprivate let classifier: HRLKNNClassifier

    /**
        Initializes a new `Classifier`.
     
        - Returns: a new `Classifier`.
     */
    public convenience init() {
        self.init(context: Context(), dataFrame: DataFrame(), classifier: HRLKNNClassifier())
    }

    /**
        Initializes a new `Classifier`.
     
        - Parameters:
            - context: `ContextProtocol` to handle the internal state of the `Classifier`
            - dataFrame: `Dataframe` to store data that will be used to train the `Classifier`
            - classifier: KNN classifier that, once trained, will make the predictions

        - Returns: a new `Classifier`.
     */
    init(context: ContextProtocol, dataFrame: DataFrameProtocol, classifier: HRLKNNClassifier) {
        self.context = context
        self.dataFrame = dataFrame
        self.classifier = classifier

        self.context.delegate = self
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

    /// Disable predictions, accept more new training data
    public func rollback() {
        context.rollbackClassifier()
    }
}

extension Classifier: ContextDelegate {
    func context(_ context: ContextProtocol,
                 addTrainingData trainingData: Classifier.TrainingData) {
        dataFrame.append(record: trainingData.record, isWorkingOut: trainingData.isWorkingOut)
    }

    func contextWillTrainClassifier(_ context: ContextProtocol) -> Bool {
        let recordCountPerWeekday = dataFrame.recordCountPerWeekday

        return recordCountPerWeekday.reduce(true, { $0 && ($1 >= Constants.minRecordsPerWeekday)})
    }

    func contextTrainClassifier(_ context: ContextProtocol) {
        let matrix = HRLMatrix()
        matrix.fill(with: dataFrame)

        classifier.train(with: matrix)
    }

    func context(_ context: ContextProtocol,
                 predictWorkingOutForRecord record: Record) -> WorkingOut {
        let predictedClass = classifier.predictClass(for: record)

        return WorkingOut(rawValue: predictedClass)!
    }
}
