//
//  RecordTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 27/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLAlgorithms
@testable import HRLClassifier

class RecordTest: XCTestCase {
    func testAnyDateAndAnyBPM_init_createVectorWithExpectedNumberOfValues() {
        // given
        let date = Date()
        let bpm = Constants.anyBPM

        // when
        let record = Record(date: date, bpm: bpm)

        // then
        XCTAssertEqual(record.count(), Constants.valueCount)
    }

    func testAnyDateAndKnownBPM_init_createVectorWithExpectedBPMValue() {
        // given
        let date = Date()
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
        let date = HelperDate.makeDate(secondsFromGMT: secondsFromGMT,
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

        let date = HelperDate.makeDate(secondsFromGMT: secondsFromGMT,
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

    func testDatesForEachWeekDay_initRecordsWithDates_eachRecordHasTheExpectedWeekdayValue() {
        // given
        let sunday = HelperDate.anySunday()
        let monday = HelperDate.nextDay(to: sunday)
        let tuesday = HelperDate.nextDay(to: monday)
        let wednesday = HelperDate.nextDay(to: tuesday)
        let thursday = HelperDate.nextDay(to: wednesday)
        let friday = HelperDate.nextDay(to: thursday)
        let saturday = HelperDate.nextDay(to: friday)

        let bpm = Constants.anyBPM

        // when
        let sundayRecord = Record(date: sunday, bpm: bpm)
        let mondayRecord = Record(date: monday, bpm: bpm)
        let tuesdayRecord = Record(date: tuesday, bpm: bpm)
        let wednesdayRecord = Record(date: wednesday, bpm: bpm)
        let thursdayRecord = Record(date: thursday, bpm: bpm)
        let fridayRecord = Record(date: friday, bpm: bpm)
        let saturdayRecord = Record(date: saturday, bpm: bpm)

        // then
        XCTAssertEqual(sundayRecord.weekday, 1)
        XCTAssertEqual(mondayRecord.weekday, 2)
        XCTAssertEqual(tuesdayRecord.weekday, 3)
        XCTAssertEqual(wednesdayRecord.weekday, 4)
        XCTAssertEqual(thursdayRecord.weekday, 5)
        XCTAssertEqual(fridayRecord.weekday, 6)
        XCTAssertEqual(saturdayRecord.weekday, 7)
    }

    func testDatesForEachWeekDay_initRecordsWithDates_createVectorsWithSameWeekDaysAsRecords() {
        // given
        let sunday = HelperDate.anySunday()
        let monday = HelperDate.nextDay(to: sunday)
        let tuesday = HelperDate.nextDay(to: monday)
        let wednesday = HelperDate.nextDay(to: tuesday)
        let thursday = HelperDate.nextDay(to: wednesday)
        let friday = HelperDate.nextDay(to: thursday)
        let saturday = HelperDate.nextDay(to: friday)

        let bpm = Constants.anyBPM

        // when
        let sundayRecord = Record(date: sunday, bpm: bpm)
        let mondayRecord = Record(date: monday, bpm: bpm)
        let tuesdayRecord = Record(date: tuesday, bpm: bpm)
        let wednesdayRecord = Record(date: wednesday, bpm: bpm)
        let thursdayRecord = Record(date: thursday, bpm: bpm)
        let fridayRecord = Record(date: friday, bpm: bpm)
        let saturdayRecord = Record(date: saturday, bpm: bpm)

        // then
        XCTAssertEqual(Double(sundayRecord.weekday),
                       sundayRecord.value(at: Constants.weekDayIndex))
        XCTAssertEqual(Double(mondayRecord.weekday),
                       mondayRecord.value(at: Constants.weekDayIndex))
        XCTAssertEqual(Double(tuesdayRecord.weekday),
                       tuesdayRecord.value(at: Constants.weekDayIndex))
        XCTAssertEqual(Double(wednesdayRecord.weekday),
                       wednesdayRecord.value(at: Constants.weekDayIndex))
        XCTAssertEqual(Double(thursdayRecord.weekday),
                       thursdayRecord.value(at: Constants.weekDayIndex))
        XCTAssertEqual(Double(fridayRecord.weekday),
                       fridayRecord.value(at: Constants.weekDayIndex))
        XCTAssertEqual(Double(saturdayRecord.weekday),
                       saturdayRecord.value(at: Constants.weekDayIndex))
    }

    func testArchivedRecord_initWithCoder_returnRecordEqualToOriginal() {
        // given
        let originalRecord = HelperRecord.anyRecord()
        let archivedRecord = NSKeyedArchiver.archivedData(withRootObject: originalRecord)

        // wnen
        let record = NSKeyedUnarchiver.unarchiveObject(with: archivedRecord)

        // then
        XCTAssertEqual(record  as! Record, originalRecord)
    }
}

private extension RecordTest {
    enum Constants {
        static let weekDayIndex = HRLSize(0)
        static let timeIntervalFromMidnightIndex = HRLSize(1)
        static let bpmIndex = HRLSize(2)
        static let valueCount = HRLSize(3)

        static let anyBPM = HelperRecord.Constants.anyBPM
        static let knownBPM = Float(72)
    }

    static func timeIntervalFromMidnight(secondsFromGMT: Int,
                                         hour: Int,
                                         minute: Int,
                                         second: Int) -> TimeInterval {
        let timeInterval = hour * 60 * 60 + minute * 60 + second - secondsFromGMT

        return TimeInterval(timeInterval >= 0 ? timeInterval : 24 * 60 * 60 + timeInterval)
    }
}
