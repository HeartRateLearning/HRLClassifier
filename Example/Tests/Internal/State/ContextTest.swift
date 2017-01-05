//
//  ContextTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class ContextTest: XCTestCase {

    let sut = Context()

    let delegate = ContextDelegateTestDouble()

    let anyState = AddingTrainingDataState()
    let anyRecord = Record(date: Date(), bpm: Float(72))

    override func setUp() {
        super.setUp()

        sut.delegate = delegate
    }

    func testConfiguredSut_stateDelegateAddTrainingData_forwardToContextDelegate() {
        // when
        sut.state(anyState, addTrainingData: (record: anyRecord, isWorkingOut: false))

        // then
        XCTAssertEqual(delegate.addTrainingDataCount, 1)
    }

    func testSutWithoutDelegate_stateDelegateWillTrainClassifier_returnFalse() {
        // given
        sut.delegate = nil

        // when
        let result = sut.stateWillTrainClassifier(anyState)

        // then
        XCTAssertFalse(result)
    }

    func testConfiguredSut_stateDelegateWillTrainClassifier_forwardToContextDelegate() {
        // when
        _ = sut.stateWillTrainClassifier(anyState)

        // then
        XCTAssertEqual(delegate.willTrainClassifierCount, 1)
    }

    func testConfiguredSut_stateDelegateTrainClassifier_forwardToContextDelegate() {
        // when
        sut.stateTrainClassifier(anyState)

        // then
        XCTAssertEqual(delegate.trainClassifierCount, 1)
    }

    func testSutWithoutDelegate_stateDelegateWillDeployClassifier_returnFalse() {
        // given
        sut.delegate = nil

        // when
        let result = sut.stateWillDeployClassifier(anyState)

        // then
        XCTAssertFalse(result)
    }

    func testConfiguredSut_stateDelegateWillDeployClassifier_forwardToContextDelegate() {
        // when
        _ = sut.stateWillDeployClassifier(anyState)

        // then
        XCTAssertEqual(delegate.willDeployClassifierCount, 1)
    }

    func testSutWithoutDelegate_stateDelegatePredictWorkingOutForRecord_returnUnknown() {
        // given
        sut.delegate = nil

        // when
        let result = sut.state(anyState, predictWorkingOutForRecord: anyRecord)

        // then
        XCTAssertEqual(result, .unknown)
    }

    func testConfiguredSut_stateDelegatePredictWorkingOutForRecord_forwardToContextDelegate() {
        // when
        _ = sut.state(anyState, predictWorkingOutForRecord: anyRecord)

        // then
        XCTAssertEqual(delegate.predictWorkingOutForRecordCount, 1)
    }
}
