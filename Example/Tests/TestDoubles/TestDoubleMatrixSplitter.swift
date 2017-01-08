//
//  TestDoubleMatrixSplitter.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import HRLAlgorithms

final class TestDoubleMatrixSplitter: NSObject {
    fileprivate(set) var splittedMatrixCount = 0
}

extension TestDoubleMatrixSplitter: HRLMatrixSplitterProtocol {
    func splittedMatrix(with matrix: HRLMatrix, trainingBias: HRLFloat) -> HRLSplittedMatrix {
        splittedMatrixCount += 1

        return HRLSplittedMatrix(training: TestDoubleMatrix(), test: TestDoubleMatrix())
    }
}
