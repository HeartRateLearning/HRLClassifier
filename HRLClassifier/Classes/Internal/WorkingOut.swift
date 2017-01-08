//
//  WorkingOut.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 27/12/2016.
//
//

import Foundation
import HRLAlgorithms

/// Value returned after predicting if a person is working out.
public enum WorkingOut: HRLClass {
    /// The `Classifier` does not know: is it trained?, ...
    case unknown = 0
    /// The user **is NOT** working out.
    case `false` = 1
    /// The user **IS** working out.
    case `true` = 2

    /**
        Initializes a new `WorkingOut` instance with a `Bool` value.

        - Parameter isWorkingOut: `Bool` value.

        - Returns: a new `WorkingOut` instance.
     */
    public init(_ isWorkingOut: Bool) {
        self = (isWorkingOut ? .`true` : .`false`)
    }
}

extension Bool {
    /**
        Initializes a `Bool` value with a `WorkingOut` instance if it is
        `WorkingOut.true` or `WorkingOut.false`.

        - Parameter workingOut: a `WorkingOut` instance.

        - Returns: a new `Bool` value.
     */
    init?(_ workingOut: WorkingOut) {
        switch workingOut {
        case .true:
            self = true
        case .false:
            self = false
        case .unknown:
            return nil
        }
    }
}
