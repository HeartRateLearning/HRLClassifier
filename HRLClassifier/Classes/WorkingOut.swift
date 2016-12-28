//
//  WorkingOut.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 27/12/2016.
//
//

import Foundation

enum WorkingOut: UInt {
    case `false` = 0
    case `true` = 1

    init(_ isWorkingOut: Bool) {
        self = (isWorkingOut ? .`true` : .`false`)
    }
}

extension Bool {
    init(_ workingOut: WorkingOut) {
        if workingOut == .true {
            self = true
        } else {
            self = false
        }
    }
}
