//
//  ClassifierFactory.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 07/01/2017.
//
//

import Foundation
import HRLAlgorithms

// MARK: - Error types

/// Possible errors while making a new `Classifier`.
public enum ClassifierFactoryError: Error {
    /// Provided `DataFrame` did not have enough data to create a `Classifier`
    /// able to make accurate predictions.
    case insufficientData
}

// MARK: - Protocol definitions

/// Factory to make a `Classifier`
public protocol ClassifierFactoryProtocol {
    /**
        Factory method to create a new `Classifier`.

        - Parameter dataFrame: A `DataFrame` instance.
     
        - Returns: a new `Classifier` ready to make predictions.
     
        - Throws:
            - `ClassifierFactoryError.insufficientData` if the provided `dataFrame` did
              not have enough data so it was not possible to create a `Classifier` able
              to make accurate predictions.
     */
    func makeClassifier(dataFrame: DataFrame) throws -> ClassifierProtocol
}

// MARK: - Properties & public methods

/// Implementation of protocol: `ClassifierFactoryProtocol`
public final class ClassifierFactory {
    // MARK: - Private properties

    fileprivate let splitter: HRLMatrixSplitterProtocol
    fileprivate let factory: HRLTrainedKNNClassifierFactoryProtocol

    // MARK: - Init methods

    /**
        Initializes a factory.
     
        - Returns: A new factory.
     */
    public convenience init() {
        self.init(splitter: HRLMatrixSplitter(), factory: HRLTrainedKNNClassifierFactory())
    }

    /**
        Initializes a factory.
     
        - Parameters:
            - splitter: Used to split a `DataFrame` into training & test sets.
            - factory: factory to create K-NN classifiers.

        - Returns: A new factory.
     */
    init(splitter: HRLMatrixSplitterProtocol, factory: HRLTrainedKNNClassifierFactoryProtocol) {
        self.splitter = splitter
        self.factory = factory
    }
}

// MARK: - ClassifierFactoryProtocol methods

extension ClassifierFactory: ClassifierFactoryProtocol {
    public func makeClassifier(dataFrame: DataFrame) throws -> ClassifierProtocol {
        let trainedKNNClassifier = try makeTrainedKNNClassifier(with: dataFrame)

        return Classifier(trainedKNNClassifier: trainedKNNClassifier)
    }
}

// MARK: - Private methods

private extension ClassifierFactory {
    enum Constants {
        static let trainingBias = HRLFloat(0.75)
        static let minRecordsPerWeekday = 80
        static let minAccuracyToMakePredictions = HRLFloat(0.9)
    }

    func makeTrainedKNNClassifier(with dataFrame: DataFrame) throws -> HRLTrainedKNNClassifier {
        guard isThereEnoughRecordsPerWeekday(in: dataFrame) else {
            throw ClassifierFactoryError.insufficientData
        }

        let splittedMatrix = splitter.splittedMatrix(with: dataFrame,
                                                     trainingBias: Constants.trainingBias)
        let trainingMatrix = splittedMatrix.trainingMatrix
        let testMatrix = splittedMatrix.testMatrix

        let trainedKNNClassifier = factory.makeTrainedKNNClassifier(with: trainingMatrix)

        let accuracy = trainedKNNClassifier.estimatedAccuracy(with: testMatrix)
        guard accuracy >= Constants.minAccuracyToMakePredictions else {
            throw ClassifierFactoryError.insufficientData
        }

        return trainedKNNClassifier
    }

    func isThereEnoughRecordsPerWeekday(in dataFrame: DataFrame) -> Bool {
        let recordCountPerWeekday = dataFrame.recordCountPerWeekday

        return recordCountPerWeekday.reduce(true, { $0 && ($1 >= Constants.minRecordsPerWeekday)})
    }
}
