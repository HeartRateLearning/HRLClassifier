//
//  Record.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 22/12/2016.
//
//

import Foundation
import HRLAlgorithms

/// A heart rate record as expected by a `Classifier` or a `DataFrame`.
final public class Record: NSObject {
    fileprivate let values: [HRLValue]

    fileprivate static let calendar = defaultCalendar()

    /**
        Initializes a new heart rate record.
     
        - Parameters:
            - date: Date when the heart rate was recorded
            - bpm: Beats Per Minute when the heart rate was recorded
     
        - Returns: A new heart rate record.
     */
    public init(date: Date, bpm: Float) {
        values = [
            HRLValue(Record.weekday(from: date)),
            HRLValue(Record.timeIntervalFromMidnight(to: date)),
            HRLValue(bpm)
        ]
    }
}

extension Record: HRLVector {
    public func count() -> HRLSize {
        return HRLSize(values.count)
    }

    public func value(at index: HRLSize) -> HRLValue {
        return values[Int(index)]
    }
}

private extension Record {
    enum Constants {
        static let TimeZoneGMT = "GMT"
        static let LocalePOSIX = "en_US_POSIX"
    }

    static func defaultCalendar() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: Constants.TimeZoneGMT)!
        calendar.locale = Locale(identifier: Constants.LocalePOSIX)

        return calendar
    }

    static func weekday(from date: Date) -> Int {
        return calendar.component(.weekday, from: date)
    }

    static func timeIntervalFromMidnight(to date: Date) -> TimeInterval {
        let midnight = startOfDay(for: date)

        return date.timeIntervalSince(midnight)
    }

    static func startOfDay(for date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                 from: date)
        components.hour = 0
        components.minute = 0
        components.second = 0

        return calendar.date(from: components)!
    }
}
