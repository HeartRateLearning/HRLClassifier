//
//  ClassifierTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 03/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLAlgorithms
@testable import HRLClassifier

class ClassifierTest: XCTestCase {

    var sut: Classifier!

    let context = ContextTestDouble()
    let dataFrame = DataFrameTestDouble()

    override func setUp() {
        super.setUp()

        sut = Classifier(context: context, dataFrame: dataFrame, classifier: HRLKNNClassifier())
    }

    func test_addTrainingData_forwardToContext() {
        // when
        sut.add(trainingData: anyTrainingData())

        // then
        XCTAssertEqual(context.addTrainingDataCount, 1)
    }

    func test_train_forwardToContext() {
        // when
        sut.train()

        // then
        XCTAssertEqual(context.trainClassifierCount, 1)
    }

    func test_calculatedClassificationAccuracy_forwardToContext() {
        // when
        _ = sut.calculatedClassificationAccuracy()

        // then
        XCTAssertEqual(context.calculatedClassificationAccuracyCount, 1)
    }

    func test_predictedWorkingOut_forwardToContext() {
        // when
        _ = sut.predictedWorkingOut(for: anyRecord())

        // then
        XCTAssertEqual(context.predictedWorkingOutCount, 1)
    }

    func test_rollback_forwardToContext() {
        // when
        sut.rollback()

        // then
        XCTAssertEqual(context.rollbackClassifierCount, 1)
    }

    func test_contextAddTrainingData_appendToDataFrame() {
        // when
        sut.context(context, addTrainingData: anyTrainingData())

        // then
        XCTAssertEqual(dataFrame.appendCount, 1)
    }

    func testNotEnoughRecordsInDataFrame_contextWillTrainClassifier_returnFalse() {
        // given
        let firstDayCount = Classifier.Constants.minRecordsPerWeekday
        let secondDayCount = Classifier.Constants.minRecordsPerWeekday - 1
        dataFrame.recordCountPerWeekday = [firstDayCount, secondDayCount]

        // when
        let result = sut.contextWillTrainClassifier(context)

        // then
        XCTAssertFalse(result)
    }

    func testEnoughRecordsInDataFrame_contextWillTrainClassifier_returnTrue() {
        // given
        let firstDayCount = Classifier.Constants.minRecordsPerWeekday
        let secondDayCount = Classifier.Constants.minRecordsPerWeekday
        dataFrame.recordCountPerWeekday = [firstDayCount, secondDayCount]

        // when
        let result = sut.contextWillTrainClassifier(context)

        // then
        XCTAssertTrue(result)
    }
}

private extension ClassifierTest {
    enum Constants {
        static let anyBPM = Float(50)
    }

    func anyTrainingData() -> Classifier.TrainingData {
        return (record: anyRecord(), isWorkingOut: false)
    }

    func anyRecord() -> Record {
        return Record(date: Date(), bpm: Constants.anyBPM)
    }
}
