//
//  RecordTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 27/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class RecordTest: XCTestCase {
    func testAnyDateAndAnyBPM_init_createVectorWithExpectedNumberOfValues() {
        // given
        let date = RecordTest.anyDate()
        let bpm = Constants.anyBPM

        // when
        let record = Record(date: date, bpm: bpm)

        // then
        XCTAssertEqual(record.count(), Constants.valueCount)
    }

    func testAnyDateAndKnownBPM_init_createVectorWithExpectedBPMValue() {
        // given
        let date = RecordTest.anyDate()
        let bpm = Constants.knownBPM

        // when
        let record = Record(date: date, bpm: bpm)

        // then
        XCTAssertEqual(record.value(at: Constants.bpmIndex), Double(bpm))
    }

    func testKnownGMTDateAndAnyBPM_init_createVectorWithExpectedtimeIntervalFromMidnightValue() {
        // given
        let hour = 17
        let minute = 0
        let second = 0
        let secondsFromGMT = 0
        let date = RecordTest.date(secondsFromGMT: secondsFromGMT,
                                   hour: hour,
                                   minute: minute,
                                   second: second)
        let bpm = Constants.anyBPM

        // when
        let record = Record(date: date, bpm: bpm)

        // then
        let timeInterval = RecordTest.timeIntervalFromMidnight(secondsFromGMT: secondsFromGMT,
                                                               hour: hour,
                                                               minute: minute,
                                                               second: second)

        XCTAssertEqual(record.value(at: Constants.timeIntervalFromMidnightIndex), timeInterval)
    }

    func testKnownNonGMTDateAndAnyBPM_init_createVectorWithExpectedTimeIntervalFromMidnightValue() {
        // given
        let hour = 1
        let minute = 0
        let second = 0

        // Notice that, because the time zone is 1 hour more than the number of hours,
        // the UTC day will be the day before. I.e. the UTC date is: 2016-12-26 23:00:00 UTC.
        let secondsFromGMT = (hour + 1) * 60 * 60

        let date = RecordTest.date(secondsFromGMT: secondsFromGMT,
                                   hour: hour,
                                   minute: minute,
                                   second: second)
        let bpm = Constants.anyBPM

        // when
        let record = Record(date: date, bpm: bpm)

        // then
        let timeInterval = RecordTest.timeIntervalFromMidnight(secondsFromGMT: secondsFromGMT,
                                                               hour: hour,
                                                               minute: minute,
                                                               second: second)

        XCTAssertEqual(record.value(at: Constants.timeIntervalFromMidnightIndex), timeInterval)
    }

    func testDatesForEachWeekDay_initRecordsWithDates_createVectorsWith7DifferentsWeekDayValues() {
        // given
        let anyDate = RecordTest.anyDate()

        var dates: [Date]  = []
        for i in 0..<14 {
            let timeInterval = TimeInterval(i * 24 * 60 * 60)
            let date = anyDate.addingTimeInterval(timeInterval)

            dates.append(date)
        }

        let bpm = Constants.anyBPM

        // when
        let repeatedWeekDays = dates.map { date -> Double in
            let record = Record(date: date, bpm: bpm)

            return record.value(at: Constants.weekDayIndex)
        }

        let weekDays = Set(repeatedWeekDays)

        // then
        XCTAssertEqual(weekDays.count, 7)
    }
}

private extension RecordTest {
    enum Constants {
        static let weekDayIndex = UInt64(0)
        static let timeIntervalFromMidnightIndex = UInt64(1)
        static let bpmIndex = UInt64(2)
        static let valueCount = UInt64(3)

        static let anyBPM = Float(50)
        static let knownBPM = Float(72)
    }

    static func anyDate() -> Date {
        return Date(timeIntervalSinceReferenceDate: 0)
    }

    static func date(secondsFromGMT: Int,
                     hour: Int,
                     minute: Int,
                     second: Int,
                     year: Int = 2016,
                     month: Int = 12,
                     day: Int = 27) -> Date {
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

    static func timeIntervalFromMidnight(secondsFromGMT: Int,
                                         hour: Int,
                                         minute: Int,
                                         second: Int) -> TimeInterval {
        let timeInterval = hour * 60 * 60 + minute * 60 + second - secondsFromGMT

        return TimeInterval(timeInterval >= 0 ? timeInterval : 24 * 60 * 60 + timeInterval)
    }
}
