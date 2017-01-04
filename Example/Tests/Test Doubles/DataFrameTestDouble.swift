//
//  DataFrameTestDouble.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 03/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

@testable import HRLAlgorithms
@testable import HRLClassifier

final class DataFrameTestDouble: NSObject {
    fileprivate(set) var appendCount = 0

    var recordCountPerWeekday: [Int] = []
}

extension DataFrameTestDouble: DataFrameProtocol {
    func append(record: Record, isWorkingOut: Bool) {
        appendCount += 1
    }
}

extension DataFrameTestDouble: HRLMatrixDataSource {
    public func rowCount() -> HRLSize {
        return 0
    }

    public func columnCount() -> HRLSize {
        return 0
    }

    public func value(atRow row: HRLSize, column: HRLSize) -> HRLValue {
        return 0
    }

    public func `class`(forRow row: HRLSize) -> UInt {
        return 0
    }
}
