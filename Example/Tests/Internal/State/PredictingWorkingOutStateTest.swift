//
//  PredictingWorkingOutStateTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class PredictingWorkingOutStateTest: XCTestCase {
    
    let sut = PredictingWorkingOutState()

    let delegate = StateDelegateTestDouble()
    let stateChanger = StateChangingTestDouble()

    let anyRecord = Record(date: Date(), bpm: Float(72))

    override func setUp() {
        super.setUp()

        sut.delegate = delegate
        sut.stateChanger = stateChanger
    }

    func testConfiguredSut_addTrainingData_doesNotforwardToDelegate() {
        // when
        sut.add(trainingData: (record: anyRecord, isWorkingOut: false))

        // then
        XCTAssertEqual(delegate.addTrainingDataCount, 0)
    }

    func testSutThatAllowsTraining_trainClassifier_neitherForwardToDelegateNorChangeState() {
        // given
        delegate.willTrainClassifierResult = true

        // when
        sut.trainClassifier()

        // then
        XCTAssertEqual(delegate.willTrainClassifierCount, 0)
        XCTAssertEqual(delegate.trainClassifierCount, 0)
        XCTAssertEqual(stateChanger.changeToPreDeployedCount, 0)
    }

    func testSutThatAllowsDeploying_deployClassifier_neitherForwardToDelegateNorChangeState() {
        // given
        delegate.willDeployClassifierResult = true

        // when
        sut.deployClassifier()

        // then
        XCTAssertEqual(delegate.willDeployClassifierCount, 0)
        XCTAssertEqual(stateChanger.changeToPredictingWorkingOutCount, 0)
    }

    func testSutWithoutDelegate_predictedWorkingOut_returnUnkwnown() {
        // given
        sut.delegate = nil

        // when
        let result = sut.predictedWorkingOut(for: anyRecord)

        // then
        XCTAssertEqual(result, .unknown)
    }

    func testConfiguredSut_predictedWorkingOut_forwardToDelegate() {
        // when
        _ = sut.predictedWorkingOut(for: anyRecord)

        // then
        XCTAssertEqual(delegate.predictWorkingOutForRecordCount, 1)
    }

    func testConfiguredSut_rollbackClassifier_changesState() {
        // when
        sut.rollbackClassifier()

        // then
        XCTAssertEqual(stateChanger.changeToAddingTrainingDataCount, 1)
    }
}
