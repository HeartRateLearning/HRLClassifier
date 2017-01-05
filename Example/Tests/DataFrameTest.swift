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
        dataFrame.append(record: anyRecord(), isWorkingOut: true)

        // when
        let thisClass = dataFrame.class(forRow: 0)

        // then
        XCTAssertEqual(thisClass, WorkingOut.true.rawValue)
    }

    func testDataFrameWithAppendedWorkingOutToFalse_classForRow_returnWorkingOutFalse() {
        // given
        let dataFrame = DataFrame()
        dataFrame.append(record: anyRecord(), isWorkingOut: false)

        // when
        let thisClass = dataFrame.class(forRow: 0)

        // then
        XCTAssertEqual(thisClass, WorkingOut.false.rawValue)
    }

    func testTwoRecordsOnSunday_appendRecords_increaseRecordCountForSunday() {
        // given
        let dataFrame = DataFrame()

        // when
        dataFrame.append(record: anyRecordOnSunday(), isWorkingOut: false)
        dataFrame.append(record: anyRecordOnSunday(), isWorkingOut: false)

        // then
        XCTAssertEqual(dataFrame.recordCountPerWeekday[0], 2)
    }
}

private extension DataFrameTest {
    enum Constants {
        static let anyBPM = Float(50)
    }

    func anyRecord() -> Record {
        return Record(date: Date(), bpm: Constants.anyBPM)
    }

    func anyRecordOnSunday() -> Record {
        let sunday = DataFrameTest.date(secondsFromGMT: 0,
                                        hour: 1,
                                        minute: 0,
                                        second: 0,
                                        year: 2017,
                                        month: 1,
                                        day: 1)

        return Record(date: sunday, bpm: Constants.anyBPM)
    }

    static func date(secondsFromGMT: Int,
                     hour: Int,
                     minute: Int,
                     second: Int,
                     year: Int,
                     month: Int,
                     day: Int) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)!

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        return calendar.date(from: dateComponents)!
    }
}
