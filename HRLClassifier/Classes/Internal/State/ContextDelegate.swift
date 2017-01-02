//
//  ContextDelegate.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//
//

import Foundation

protocol ContextDelegate: class {
    func context(_ context: Context, addTrainingData trainingData: Classifier.TrainingData)

    func contextWillTrainClassifier(_ context: Context) -> Bool
    func contextTrainClassifier(_ context: Context)

    func context(_ context: Context, predictWorkingOutForRecord record: Record) -> WorkingOut

    func contextRollbackClassifier(_ context: Context)
}
