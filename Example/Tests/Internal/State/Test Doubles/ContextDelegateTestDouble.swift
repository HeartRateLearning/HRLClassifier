//
//  ContextDelegateTestDouble.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

@testable import HRLClassifier

class ContextDelegateTestDouble {
    fileprivate(set) var addTrainingDataCount = 0
    fileprivate(set) var willTrainClassifierCount = 0
    fileprivate(set) var trainClassifierCount = 0
    fileprivate(set) var predictWorkingOutForRecordCount = 0

    var willTrainClassifierResult = false
    var predictWorkingOutForRecordResult = WorkingOut.unknown
}

extension ContextDelegateTestDouble: ContextDelegate {
    func context(_ context: Context, addTrainingData trainingData: Classifier.TrainingData) {
        addTrainingDataCount += 1
    }

    func contextWillTrainClassifier(_ context: Context) -> Bool {
        willTrainClassifierCount += 1

        return willTrainClassifierResult
    }

    func contextTrainClassifier(_ context: Context) {
        trainClassifierCount += 1
    }

    func context(_ context: Context, predictWorkingOutForRecord record: Record) -> WorkingOut {
        predictWorkingOutForRecordCount += 1

        return predictWorkingOutForRecordResult
    }
}
