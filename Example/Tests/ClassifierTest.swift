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

    let context = Context()
    let dataFrame = DataFrameTestDouble()

    override func setUp() {
        super.setUp()

        sut = Classifier(context: context, dataFrame: dataFrame, classifier: HRLKNNClassifier())
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
