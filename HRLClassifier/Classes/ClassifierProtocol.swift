//
//  ClassifierProtocol.swift
//  Pods
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//
//

import Foundation

/// A class that conforms to `ClassifierProtocol` is able to predict if
/// a person is working out or not based on the information provided in
/// a `Record`.
public protocol ClassifierProtocol {
    /**
     Use this method to make predictions.

     - Parameter record: A `Record` instance.

     - Returns: `true` if the `Classifier` estimates the user was working out.
     */
    func predictedWorkingOut(for record: Record) -> Bool
}
