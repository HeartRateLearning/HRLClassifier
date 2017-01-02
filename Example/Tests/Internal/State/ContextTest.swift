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

    func testConfiguredSut_StateDelegateAddTrainingData_forwardToContextDelegate() {
        // when
        sut.state(anyState, addTrainingData: (record: anyRecord, isWorkingOut: false))

        // then
        XCTAssertEqual(delegate.addTrainingDataCount, 1)
    }

    func testSutWithoutDelegate_willTrainClassifier_returnFalse() {
        // given
        sut.delegate = nil

        // when
        let result = sut.stateWillTrainClassifier(anyState)

        // then
        XCTAssertFalse(result)
    }

    func testConfiguredSut_willTrainClassifier_forwardToContextDelegate() {
        // when
        _ = sut.stateWillTrainClassifier(anyState)

        // then
        XCTAssertEqual(delegate.willTrainClassifierCount, 1)
    }

    func testConfiguredSut_trainClassifier_forwardToContextDelegate() {
        // when
        sut.stateTrainClassifier(anyState)

        // then
        XCTAssertEqual(delegate.trainClassifierCount, 1)
    }

    func testSutWithoutDelegate_predictWorkingOutForRecord_returnUnknown() {
        // given
        sut.delegate = nil

        // when
        let result = sut.state(anyState, predictWorkingOutForRecord: anyRecord)

        // then
        XCTAssertEqual(result, .unknown)
    }

    func testConfiguredSut_predictWorkingOutForRecord_forwardToContextDelegate() {
        // when
        _ = sut.state(anyState, predictWorkingOutForRecord: anyRecord)

        // then
        XCTAssertEqual(delegate.predictWorkingOutForRecordCount, 1)
    }

    func testConfiguredSut_rollbackClassifier_forwardToContextDelegate() {
        // when
        sut.stateRollbackClassifier(anyState)

        // then
        XCTAssertEqual(delegate.rollbackClassifierCount, 1)
    }
}
