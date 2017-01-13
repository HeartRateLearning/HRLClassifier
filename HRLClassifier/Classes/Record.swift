//
//  Record.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 22/12/2016.
//
//

import Foundation
import HRLAlgorithms

// MARK: Properties & public methods

/// A heart rate record as expected by a `Classifier` or a `DataFrame`.
public final class Record: NSObject {
    // MARK: - Public propeties
    
    /**
        Day of the week when the heart rate was recorded.

        Range: 1...7, 1 = Sunday, 2 = Monday, ...
     */
    let weekday: Int

    // MARK: - Private properties

    /// Values as expected by `HRLVector`.
    fileprivate let values: [HRLValue]

    fileprivate static let calendar = defaultCalendar()

    // MARK: - Init

    /**
        Initializes a new heart rate record.

        - Parameters:
            - date: Date when the heart rate was recorded.
            - bpm: Beats Per Minute when the heart rate was recorded.

        - Returns: A new heart rate record.
     */
    public convenience init(date: Date, bpm: Float) {
        let weekday = Record.weekday(from: date)
        let values = [
            HRLValue(weekday),
            HRLValue(Record.timeIntervalFromMidnight(to: date)),
            HRLValue(bpm)
        ]

        self.init(weekday: weekday, values: values)
    }

    /**
        Private initializer. Use convenience initializers instead.
     
        - Parameters:
            - weekday: Day of the week when the heart rate was recorded.
            - values: Values as expected by `HRLVector`.
     
        - Returns: A new heart rate record.
     */
    fileprivate init(weekday: Int, values: [HRLValue]) {
        self.weekday = weekday
        self.values = values
    }

    // MARK: - Public methods

    public override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? Record else {
            return false
        }

        return (weekday == rhs.weekday) && (values == rhs.values)
    }
}

// MARK: - NSCoding methods

extension Record: NSCoding {
    // This init does not have a `required` modifier because this class is `final`
    public convenience init?(coder aDecoder: NSCoder) {
        guard let weekday = aDecoder.decodeObject(forKey: Constants.Keys.Weekday) as? Int,
            let values = aDecoder.decodeObject(forKey: Constants.Keys.Values) as? [HRLValue]
            else {
                return nil
        }

        self.init(weekday: weekday, values: values)
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(weekday as NSNumber, forKey: Constants.Keys.Weekday)
        aCoder.encode(values, forKey: Constants.Keys.Values)
    }
}

// MARK: - HRLVector methods

extension Record: HRLVector {
    public func count() -> HRLSize {
        return HRLSize(values.count)
    }

    public func value(at index: HRLSize) -> HRLValue {
        return values[Int(index)]
    }
}

// MARK: - Private methods

private extension Record {
    enum Constants {
        static let TimeZoneGMT = "GMT"
        static let LocalePOSIX = "en_US_POSIX"

        enum Keys {
            static let Weekday = "weekday"
            static let Values = "values"
        }
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
