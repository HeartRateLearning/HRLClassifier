//
//  HelperRecord.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import HRLClassifier

final class HelperRecord {
    enum Constants {
        static let anyBPM = Float(50)
    }

    static func anyRecord() -> Record {
        return Record(date: Date(), bpm: Constants.anyBPM)
    }

    static func anyRecordOnSunday() -> Record {
        let sunday = HelperDate.anySunday()

        return Record(date: sunday, bpm: Constants.anyBPM)
    }

    static func makeRecord(at date: Date) -> Record {
        return Record(date: date, bpm: Constants.anyBPM)
    }
}
