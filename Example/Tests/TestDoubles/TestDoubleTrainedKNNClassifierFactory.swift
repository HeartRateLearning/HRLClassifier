//
//  TestDoubleTrainedKNNClassifierFactory.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import HRLAlgorithms

final class TestDoubleTrainedKNNClassifierFactory: NSObject {
    fileprivate(set) var makeTrainedKNNClassifierCount = 0
    fileprivate(set) var makeTrainedKNNClassifierWithNeighborsCount = 0

    var makeTrainedKNNClassifierResult = TestDoubleTrainedKNNClassifier()
    var makeTrainedKNNClassifierWithNeighborsResult = TestDoubleTrainedKNNClassifier()
}

extension TestDoubleTrainedKNNClassifierFactory: HRLTrainedKNNClassifierFactoryProtocol {
    func makeTrainedKNNClassifier(with matrix: HRLMatrix) -> HRLTrainedKNNClassifier {
        makeTrainedKNNClassifierCount += 1

        return makeTrainedKNNClassifierResult
    }

    func makeTrainedKNNClassifier(with matrix: HRLMatrix, neighborsCount: HRLSize) -> HRLTrainedKNNClassifier {
        makeTrainedKNNClassifierWithNeighborsCount += 1

        return makeTrainedKNNClassifierWithNeighborsResult
    }
}
