//
//  StateChangingTestDouble.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

@testable import HRLClassifier

final class StateChangingTestDouble {
    fileprivate(set) var changeToAddingTrainingDataCount = 0
    fileprivate(set) var changeToPredictingWorkingOutCount = 0
}

extension StateChangingTestDouble: StateChanging {
    func changeToAddingTrainingData() {
        changeToAddingTrainingDataCount += 1
    }

    func changeToPredictingWorkingOut() {
        changeToPredictingWorkingOutCount += 1
    }
}
