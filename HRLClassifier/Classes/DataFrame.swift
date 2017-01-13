//
//  DataFrame.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 26/12/2016.
//
//

import Foundation
import HRLAlgorithms

// MARK: - Properties & public methods

/// A `DataFrame` contains all the necessary data to train a `Classifier`:
/// heart rates at different moments and if the user was working out or not.
public final class DataFrame: NSObject {
    // MARK: - Public properties

    /**
     Each position of `recordCountPerWeekday` represents a day of the week
     and the value contained on each position is the number of appended
     records for that day:
     recordCountPerWeekday[0] = number of records on Sunday,
     recordCountPerWeekday[1] = number of records on Monday,
     ...
     */
    fileprivate(set) var recordCountPerWeekday = Array(repeating: 0, count: Constants.daysPerWeek)

    // MARK: - Private properties

    fileprivate var records: [Record] = []
    fileprivate var classes: [HRLClass] = []

    // MARK: - Public methods
    
    /**
        Append a new `record` to the dataframe and if the user `isWorkingOut` or not at the
        moment the `record` was created.

        - Parameteres:
            - record: a `Record` instance.
            - isWorkingOut: if the user was working out or not at the moment `record` was recorded.
     */
    public func append(record: Record, isWorkingOut: Bool) {
        recordCountPerWeekday[record.weekday - 1] += 1

        records.append(record)
        classes.append(WorkingOut(isWorkingOut).rawValue)
    }
}

// MARK: HRLMatrix methods

extension DataFrame: HRLMatrix {
    public func rowCount() -> HRLSize {
        return HRLSize(records.count)
    }

    public func columnCount() -> HRLSize {
        guard let record = records.first else { return 0 }

        return record.count()
    }

    public func value(atRow row: HRLSize, column: HRLSize) -> HRLValue {
        let record = records[Int(row)]

        return record.value(at: column)
    }

    public func `class`(forRow row: HRLSize) -> HRLClass {
        return classes[Int(row)]
    }
}

// MARK: - Private methods

private extension DataFrame {
    enum Constants {
        static let daysPerWeek = 7
    }
}
