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
public final class Classifier {
    /// Defaults
    public enum Defaults {
        /// Minimum number of records per weekday required to train a `Classifier`
        static let minRecordsPerWeekday = 80
    }

    /// Errors produced while training the `Classifier`.
    public enum TrainingError: Error {
        /// There must be at least `Constants.minRecordsPerWeekday` records per weekday
        /// in the input `DataFrame`.
        case notEnoughRecordsPerWeekdayInDataFrame

        /// A trained `Classifier` must make predictions with an accuracy
        /// of `Constants.minAccuracyToMakePredictions`.
        case trainedClassifierCanNotMakeAccuratePredictions
    }

    private var classifier: HRLTrainedKNNClassifier?

    /**
        Initializes a new `Classifier`.
     
        - Returns: a new `Classifier`.
     */
    public init() {}

    /**
        In order to make predictions, you have to train the `Classifier` with this method.
     
        - Parameter dataFrame: A `DataFrame` instance.
     
        - Throws:
            - `TrainingError.notEnoughRecordsPerWeekdayInDataFrame` if `dataframe` does not have
              at least `Constants.minRecordsPerWeekday` records per weekday.
            - `TrainingError.trainedClassifierCanNotMakeAccuratePredictions` is the trained
              `Classifier` can not make predictions with an accuracy of
              `Constants.minAccuracyToMakePredictions`.
     */
    public func train(with dataFrame: DataFrame) throws {
        guard isThereEnoughRecordsPerWeekday(in: dataFrame) else {
            throw TrainingError.notEnoughRecordsPerWeekdayInDataFrame
        }

        let splitter = HRLMatrixSplitter()
        let splittedMatrix = splitter.splittedMatrix(with: dataFrame,
                                                     trainingBias: Constants.trainingBias)

        let factory = HRLTrainedKNNClassifierFactory()
        let nextClassifier = factory.makeTrainedKNNClassifier(with: splittedMatrix.trainingMatrix)

        let accuracy = nextClassifier.estimatedAccuracy(with: splittedMatrix.testMatrix)
        guard accuracy >= Constants.minAccuracyToMakePredictions else {
            throw TrainingError.trainedClassifierCanNotMakeAccuratePredictions
        }

        classifier = nextClassifier
    }

    /**
        Once the `Classifier` is trained, use this method to make predictions.

        - Parameter record: A `Record` instance.
     
        - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    public func predictedWorkingOut(for record: Record) -> WorkingOut {
        guard let predictedClass = classifier?.predictedClass(for: record) else {
            return .unknown
        }

        return WorkingOut(rawValue: predictedClass)!
    }
}

private extension Classifier {
    enum Constants {
        static let trainingBias = HRLFloat(0.75)
        static let minAccuracyToMakePredictions = HRLFloat(0.9)
    }

    func isThereEnoughRecordsPerWeekday(in dataFrame: DataFrame) -> Bool {
        let recordCountPerWeekday = dataFrame.recordCountPerWeekday

        return recordCountPerWeekday.reduce(true, { $0 && ($1 >= Defaults.minRecordsPerWeekday)})
    }
}
