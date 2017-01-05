//
//  PreDeployedStateTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 05/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class PreDeployedStateTest: XCTestCase {

    let sut = PreDeployedState()

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

    func testSutWithoutDelegate_deployClassifier_doesNotChangeState() {
        // given
        sut.delegate = nil

        // when
        sut.deployClassifier()

        // then
        XCTAssertEqual(stateChanger.changeToPredictingWorkingOutCount, 0)
    }

    func testSutThatDoesNotAllowDeploying_deployClassifier_doesNotchangeState() {
        // given
        delegate.willDeployClassifierResult = false

        // when
        sut.deployClassifier()

        // then
        XCTAssertEqual(delegate.willDeployClassifierCount, 1)
        XCTAssertEqual(stateChanger.changeToPredictingWorkingOutCount, 0)
    }

    func testSutThatAllowsTraining_trainClassifier_changeState() {
        // given
        delegate.willDeployClassifierResult = true

        // when
        sut.deployClassifier()

        // then
        XCTAssertEqual(delegate.willDeployClassifierCount, 1)
        XCTAssertEqual(stateChanger.changeToPredictingWorkingOutCount, 1)
    }

    func testConfiguredSut_predictedWorkingOut_returnUnkwnown() {
        // when
        let result = sut.predictedWorkingOut(for: anyRecord)

        // then
        XCTAssertEqual(result, .unknown)
    }

    func testConfiguredSut_predictedWorkingOut_doesNotForwardToDelegate() {
        // when
        _ = sut.predictedWorkingOut(for: anyRecord)

        // then
        XCTAssertEqual(delegate.predictWorkingOutForRecordCount, 0)
    }

    func testConfiguredSut_rollbackClassifier_changesState() {
        // when
        sut.rollbackClassifier()

        // then
        XCTAssertEqual(stateChanger.changeToAddingTrainingDataCount, 1)
    }

}
