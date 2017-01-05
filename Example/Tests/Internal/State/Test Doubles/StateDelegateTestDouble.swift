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
    fileprivate(set) var willTrainClassifierCount = 0
    fileprivate(set) var trainClassifierCount = 0
    fileprivate(set) var willDeployClassifierCount = 0
    fileprivate(set) var predictWorkingOutForRecordCount = 0

    var willTrainClassifierResult = false
    var willDeployClassifierResult = false
    var predictWorkingOutForRecordResult = WorkingOut.unknown
}

extension StateDelegateTestDouble: StateDelegate {
    func state(_ state: State, addTrainingData trainingData: Classifier.TrainingData) {
        addTrainingDataCount += 1
    }

    func stateWillTrainClassifier(_ state: State) -> Bool {
        willTrainClassifierCount += 1

        return willTrainClassifierResult
    }

    func stateTrainClassifier(_ state: State) {
        trainClassifierCount += 1
    }

    func stateWillDeployClassifier(_ state: State) -> Bool {
        willDeployClassifierCount += 1

        return willDeployClassifierResult
    }

    func state(_ state: State, predictWorkingOutForRecord record: Record) -> WorkingOut {
        predictWorkingOutForRecordCount += 1

        return predictWorkingOutForRecordResult
    }
}
