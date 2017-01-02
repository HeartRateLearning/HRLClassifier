//
//  StateChanging.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 01/01/2017.
//
//

import Foundation

protocol StateChanging: class {
    func changeToAddingTrainingData()
    func changeToPredictingWorkingOut()
}
