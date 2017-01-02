//
//  StateDelegate.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//
//

import Foundation

protocol StateDelegate: class {
    func state(_ state: State, addTrainingData trainingData: Classifier.TrainingData)

    func stateWillTrainClassifier(_ state: State) -> Bool
    func stateTrainClassifier(_ state: State)

    func state(_ state: State, predictWorkingOutForRecord record: Record) -> WorkingOut

    func stateRollbackClassifier(_ state: State)
}
