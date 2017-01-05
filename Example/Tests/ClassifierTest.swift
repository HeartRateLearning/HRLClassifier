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
    func testInitializedSut_predictedWorkingOut_returnUnknown() {
        // given
        let sut = Classifier()

        // when
        let result = sut.predictedWorkingOut(for: anyRecord())

        // then
        XCTAssertEqual(result, .unknown)
    }
}

private extension ClassifierTest {
    enum Constants {
        static let anyBPM = Float(50)
    }

    func anyRecord() -> Record {
        return Record(date: Date(), bpm: Constants.anyBPM)
    }
}
