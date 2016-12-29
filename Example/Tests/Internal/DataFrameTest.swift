//
//  DataFrameTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 27/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class DataFrameTest: XCTestCase {
    func test_init_rowCountReturnZero() {
        // when
        let dataFrame = DataFrame()

        // then
        XCTAssertEqual(dataFrame.rowCount(), 0)
    }

    func test_init_columnCountReturnZero() {
        // when
        let dataFrame = DataFrame()

        // then
        XCTAssertEqual(dataFrame.columnCount(), 0)
    }

    func testDataFrameWithAppendedWorkingOutToTrue_classForRow_returnOne() {
        // given
        let dataFrame = DataFrame()
        dataFrame.append(record: anyRecord(), isWorkingOut: true)

        // when
        let thisClass = dataFrame.class(forRow: 0)

        // then
        XCTAssertEqual(thisClass, 1)
    }

    func testDataFrameWithAppendedWorkingOutToFalse_classForRow_returnZero() {
        // given
        let dataFrame = DataFrame()
        dataFrame.append(record: anyRecord(), isWorkingOut: false)

        // when
        let thisClass = dataFrame.class(forRow: 0)

        // then
        XCTAssertEqual(thisClass, 0)
    }
}

private extension DataFrameTest {
    func anyRecord() -> Record {
        return Record(date: Date(), bpm: Float(72))
    }
}
