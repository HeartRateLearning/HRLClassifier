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
    fileprivate(set) var recordCountPerWeekday: [Int]

    // MARK: - Private properties

    /// All records in the data frame.
    fileprivate var records: [Record]

    /// Class values as expected by `HRLMatrix`.
    fileprivate var classes: [HRLClass]

    // MARK: - Init methods

    /**
        Initializes a new data frame.
     
        - Returns: A new data frame.
     */
    public convenience override init() {
        self.init(recordCountPerWeekday: Array(repeating: 0, count: Constants.daysPerWeek),
                  records: [],
                  classes: [])
    }

    /**
        Private initializer. Use convenience initializers instead.
     
        - Parameters:
            - recordCountPerWeekday: Number of records on each weekday.
            - records: All records in the data frame.
            - classes: Class values as expected by `HRLMatrix`.

        - Returns: A new data frame.
     */
    fileprivate init(recordCountPerWeekday: [Int], records: [Record], classes: [HRLClass]) {
        self.recordCountPerWeekday = recordCountPerWeekday
        self.records = records
        self.classes = classes
    }

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

    public override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? DataFrame else {
            return false
        }

        return (recordCountPerWeekday == rhs.recordCountPerWeekday) &&
            (records == rhs.records) &&
            (classes == rhs.classes)
    }
}

// MARK: - NSCoding methods

extension DataFrame: NSCoding {
    // This init does not have a `required` modifier because this class is `final`
    public convenience init?(coder aDecoder: NSCoder) {
        guard let classes = aDecoder.decodeObject(forKey: Constants.Keys.Classes) as? [HRLClass],
            let records = aDecoder.decodeObject(forKey: Constants.Keys.Records) as? [Record],
            let rc = aDecoder.decodeObject(forKey: Constants.Keys.RecordCountPerWeekday) as? [Int]
            else {
                return nil
        }

        self.init(recordCountPerWeekday: rc, records: records, classes: classes)
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(recordCountPerWeekday, forKey: Constants.Keys.RecordCountPerWeekday)
        aCoder.encode(records, forKey: Constants.Keys.Records)
        aCoder.encode(classes, forKey: Constants.Keys.Classes)
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

        enum Keys {
            static let RecordCountPerWeekday = "recordCountPerWeekday"
            static let Records = "records"
            static let Classes = "classes"
        }
    }
}
