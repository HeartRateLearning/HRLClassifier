//
//  StateDelegateTestDouble.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

@testable import HRLClassifier

final class StateDelegateTestDouble {
    fileprivate(set) var addTrainingDataCount = 0
    fileprivate(set) var willTrainClassifiderCount = 0
    fileprivate(set) var trainClassifierCount = 0
    fileprivate(set) var calculateClassificationAccuracyCount = 0
    fileprivate(set) var predictWorkingOutForRecordCount = 0

    var willTrainClassifierResult = false
    var calculateClassificationAccuracyResult = Double(0)
    var predictWorkingOutForRecordResult = WorkingOut.unknown
}

extension StateDelegateTestDouble: StateDelegate {
    func state(_ state: State, addTrainingData trainingData: Classifier.TrainingData) {
        addTrainingDataCount += 1
    }

    func stateWillTrainClassifier(_ state: State) -> Bool {
        willTrainClassifiderCount += 1

        return willTrainClassifierResult
    }

    func stateTrainClassifier(_ state: State) {
        trainClassifierCount += 1
    }

    func stateCalculateClassificationAccuracy(_ state: State) -> Double {
        calculateClassificationAccuracyCount += 1

        return calculateClassificationAccuracyResult
    }

    func state(_ state: State, predictWorkingOutForRecord record: Record) -> WorkingOut {
        predictWorkingOutForRecordCount += 1

        return predictWorkingOutForRecordResult
    }
}
