//
//  HelperDate.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

final class HelperDate {
    static func nextDay(to day: Date) -> Date {
        let dayInterval = TimeInterval(24 * 60 * 60)

        return day.addingTimeInterval(dayInterval)
    }

    static func anySunday() -> Date {
        return HelperDate.makeDate(secondsFromGMT: 0,
                                   hour: 1,
                                   minute: 0,
                                   second: 0,
                                   year: 2017,
                                   month: 1,
                                   day: 1)
    }

    static func makeDate(secondsFromGMT: Int,
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
}
