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
    /// Errors produced while training the `Classifier`
    enum TrainingError: Error {
        case notEnoughRecordsPerWeekdayInDataFrame
        case trainedClassifierCanNotMakeAccuratePredictions
    }

    private var classifier: HRLKNNClassifier?

    /**
        Initializes a new `Classifier`
     
        - Returns: a new `Classifier`
     */
    public init() {}

    /**
        In order to make predictions, you have to train the `Classifier` with this method.
     
        - Parameter dataFrame: A `DataFrame` instance
     */
    public func train(with dataFrame:DataFrame) throws {
        guard isThereEnoughRecordsPerWeekday(in: dataFrame) else {
            throw TrainingError.notEnoughRecordsPerWeekdayInDataFrame
        }

        let matrix = HRLMatrix()
        matrix.fill(with: dataFrame)

        var trainingMatrix: HRLMatrix?
        var testMatrix: HRLMatrix?
        matrix.split(intoTraining: &trainingMatrix,
                     test: &testMatrix,
                     trainingBias: Constants.trainingBias)

        let nextClassifier = HRLKNNClassifier()
        nextClassifier.train(with: trainingMatrix!)

        let accuracy = nextClassifier.calculateClassificationAccuracy(using: testMatrix!)
        guard accuracy >= Constants.minAccuracyToMakePredictions else {
            throw TrainingError.trainedClassifierCanNotMakeAccuratePredictions
        }

        classifier = nextClassifier
    }

    /**
        Once the `Classifier` is trained, use this method to make predictions.

        - Parameter record: A `Record` instance
     
        - Returns: `WorkingOut.true` only if the `Classifier` estimates the user was working out.
     */
    public func predictedWorkingOut(for record:Record) -> WorkingOut {
        guard let predictedClass = classifier?.predictClass(for: record) else {
            return .unknown
        }

        return WorkingOut(rawValue: predictedClass)!
    }
}

private extension Classifier {
    enum Constants {
        static let trainingBias = HRLFloat(0.75)
        static let minRecordsPerWeekday = 80
        static let minAccuracyToMakePredictions = HRLFloat(0.9)
    }

    func isThereEnoughRecordsPerWeekday(in dataFrame: DataFrame) -> Bool {
        let recordCountPerWeekday = dataFrame.recordCountPerWeekday

        return recordCountPerWeekday.reduce(true, { $0 && ($1 >= Constants.minRecordsPerWeekday)})
    }
}
