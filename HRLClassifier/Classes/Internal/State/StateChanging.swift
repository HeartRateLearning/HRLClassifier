//
//  StateChanging.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

/// Use this protocol to request a change of state.
/// Notice that it is a Class-Only Protocol, a struct would be copied on assigment to
/// a property.
protocol StateChanging: class {
    /// Change to: Adding Training Data.
    func changeToAddingTrainingData()

    /// Change to: Pre-deployed
    func changeToPreDeployed()

    /// Change to: Predicting Working Out.
    func changeToPredictingWorkingOut()
}
