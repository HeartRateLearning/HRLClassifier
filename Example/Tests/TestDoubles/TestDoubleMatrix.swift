//
//  TestDoubleMatrix.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import HRLAlgorithms

final class TestDoubleMatrix: NSObject {}

extension TestDoubleMatrix: HRLMatrix {
    func rowCount() -> HRLSize {
        return 0
    }

    func columnCount() -> HRLSize {
        return 0
    }

    func value(atRow row: HRLSize, column: HRLSize) -> HRLValue {
        return 0
    }

    func `class`(forRow row: HRLSize) -> HRLClass {
        return 0
    }
}
