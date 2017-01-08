//
//  ClassifierTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 05/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class ClassifierTest: XCTestCase {
    let trainedKNNClassifier = TestDoubleTrainedKNNClassifier()

    var sut: Classifier!

    override func setUp() {
        super.setUp()

        sut = Classifier(trainedKNNClassifier: trainedKNNClassifier)
    }

    func testAnyRecord_predictedWorkingOut_forwardToTrainedKNNClassifier() {
        // given
        let record = HelperRecord.anyRecord()

        // when
        _ = sut.predictedWorkingOut(for: record)

        // then
        XCTAssertEqual(trainedKNNClassifier.predictedClassCount, 1)
    }
}
