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

    func testDataFrameWithAppendedWorkingOutToTrue_classForRow_returnWorkingOutTrue() {
        // given
        let dataFrame = DataFrame()
        dataFrame.append(record: HelperRecord.anyRecord(), isWorkingOut: true)

        // when
        let thisClass = dataFrame.class(forRow: 0)

        // then
        XCTAssertEqual(thisClass, WorkingOut.true.rawValue)
    }

    func testDataFrameWithAppendedWorkingOutToFalse_classForRow_returnWorkingOutFalse() {
        // given
        let dataFrame = DataFrame()
        dataFrame.append(record: HelperRecord.anyRecord(), isWorkingOut: false)

        // when
        let thisClass = dataFrame.class(forRow: 0)

        // then
        XCTAssertEqual(thisClass, WorkingOut.false.rawValue)
    }

    func testTwoRecordsOnSunday_appendRecords_increaseRecordCountForSunday() {
        // given
        let dataFrame = DataFrame()

        // when
        dataFrame.append(record: HelperRecord.anyRecordOnSunday(), isWorkingOut: false)
        dataFrame.append(record: HelperRecord.anyRecordOnSunday(), isWorkingOut: false)

        // then
        XCTAssertEqual(dataFrame.recordCountPerWeekday[0], 2)
    }
}
