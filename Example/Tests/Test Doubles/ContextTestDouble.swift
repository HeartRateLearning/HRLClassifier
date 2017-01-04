//
//  ContextTestDouble.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 04/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

@testable import HRLClassifier

final class ContextTestDouble {
    fileprivate(set) var addTrainingDataCount = 0
    fileprivate(set) var trainClassifierCount = 0
    fileprivate(set) var predictedWorkingOutCount = 0
    fileprivate(set) var rollbackClassifierCount = 0

    weak var delegate: ContextDelegate?
    var predictedWorkingOutResult = WorkingOut.unknown
}

extension ContextTestDouble: ContextProtocol {
    func add(trainingData: Classifier.TrainingData) {
        addTrainingDataCount += 1
    }

    func trainClassifier() {
        trainClassifierCount += 1
    }

    func predictedWorkingOut(for record:Record) -> WorkingOut {
        predictedWorkingOutCount += 1

        return predictedWorkingOutResult
    }

    func rollbackClassifier() {
        rollbackClassifierCount += 1
    }
}
