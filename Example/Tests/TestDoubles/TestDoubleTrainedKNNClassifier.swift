//
//  TestDoubleTrainedKNNClassifier.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import HRLAlgorithms
import HRLClassifier

final class TestDoubleTrainedKNNClassifier: NSObject {
    fileprivate(set) var predictedClassCount = 0
    fileprivate(set) var estimatedAccuracyCount = 0

    var predictedClassResult = HRLClass(WorkingOut.false.rawValue)
    var estimatedAccuracyResult = HRLFloat(0)
}

extension TestDoubleTrainedKNNClassifier: HRLTrainedKNNClassifier {
    func predictedClass(for vector: HRLVector) -> HRLClass {
        predictedClassCount += 1

        return predictedClassResult
    }

    func estimatedAccuracy(with matrix: HRLMatrix) -> HRLFloat {
        estimatedAccuracyCount += 1
        
        return estimatedAccuracyResult
    }
}
