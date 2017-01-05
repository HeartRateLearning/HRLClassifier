//
//  AddingTrainingDataStateTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class AddingTrainingDataStateTest: XCTestCase {

    let sut = AddingTrainingDataState()

    let delegate = StateDelegateTestDouble()
    let stateChanger = StateChangingTestDouble()

    let anyRecord = Record(date: Date(), bpm: Float(72))
    
    override func setUp() {
        super.setUp()

        sut.delegate = delegate
        sut.stateChanger = stateChanger
    }

    func testConfiguredSut_addTrainingData_forwardToDelegate() {
        // when
        sut.add(trainingData: (record: anyRecord, isWorkingOut: false))

        // then
        XCTAssertEqual(delegate.addTrainingDataCount, 1)
    }

    func testSutWithoutDelegate_trainClassifier_doesNotChangeState() {
        // given
        sut.delegate = nil

        // when
        sut.trainClassifier()

        // then
        XCTAssertEqual(stateChanger.changeToPreDeployedCount, 0)
    }

    func testSutThatDoesNotAllowTraining_trainClassifier_neitherTrainClassifierNorChangeState() {
        // given
        delegate.willTrainClassifierResult = false

        // when
        sut.trainClassifier()

        // then
        XCTAssertEqual(delegate.willTrainClassifierCount, 1)
        XCTAssertEqual(delegate.trainClassifierCount, 0)
        XCTAssertEqual(stateChanger.changeToPreDeployedCount, 0)
    }

    func testSutThatAllowsTraining_trainClassifier_forwardToDelegateAndChangeState() {
        // given
        delegate.willTrainClassifierResult = true

        // when
        sut.trainClassifier()

        // then
        XCTAssertEqual(delegate.willTrainClassifierCount, 1)
        XCTAssertEqual(delegate.trainClassifierCount, 1)
        XCTAssertEqual(stateChanger.changeToPreDeployedCount, 1)
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

    func testConfiguredSut_rollbackClassifier_doesNotChangeState() {
        // when
        sut.rollbackClassifier()

        // then
        XCTAssertEqual(stateChanger.changeToAddingTrainingDataCount, 0)
    }
}
