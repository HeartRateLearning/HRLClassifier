//
//  ClassifierFactoryTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 08/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

import HRLAlgorithms

class ClassifierFactoryTest: XCTestCase {
    let splitter = TestDoubleMatrixSplitter()
    let factory = TestDoubleTrainedKNNClassifierFactory()
    let trainedKNNClassifier = TestDoubleTrainedKNNClassifier()

    var sut: ClassifierFactory!
    
    override func setUp() {
        super.setUp()

        trainedKNNClassifier.estimatedAccuracyResult = Constants.highAccuracy
        factory.makeTrainedKNNClassifierResult = trainedKNNClassifier

        sut = ClassifierFactory(splitter: splitter, factory: factory)
    }

    func testEmptyDataFrame_makeClassifier_throwError() {
        // given
        let dataFrame = emptyDataFrame()

        // when / then
        XCTAssertThrowsError(try sut.makeClassifier(with: dataFrame))
    }

    func testNonEmptyDataFrame_makeClassifier_splitDataFrame() {
        // given
        let dataFrame = nonEmptyDataFrame()

        // when
        _ = try? sut.makeClassifier(with: dataFrame)

        // then
        XCTAssertEqual(splitter.splittedMatrixCount, 1)
    }

    func testNonEmptyDataFrame_makeClassifier_makeTrainedKNNClassifier() {
        // given
        let dataFrame = nonEmptyDataFrame()

        // when
        _ = try? sut.makeClassifier(with: dataFrame)

        // then
        XCTAssertEqual(factory.makeTrainedKNNClassifierCount, 1)
    }

    func testNonEmptyDataFrame_makeClassifier_getEstimatedAccuracy() {
        // given
        let dataFrame = nonEmptyDataFrame()

        // when
        _ = try? sut.makeClassifier(with: dataFrame)

        // then
        XCTAssertEqual(trainedKNNClassifier.estimatedAccuracyCount, 1)
    }

    func testNonEmptyDataFrameAndLowAccuracyClassifier_makeClassifier_throwError() {
        // given
        let dataFrame = nonEmptyDataFrame()
        trainedKNNClassifier.estimatedAccuracyResult = Constants.lowAccuracy

        // when / then
        XCTAssertThrowsError(try sut.makeClassifier(with: dataFrame))
    }
}

private extension ClassifierFactoryTest {
    enum Constants {
        static let minRecordsPerWeekday = 80
        static let highAccuracy = HRLFloat(1.0)
        static let lowAccuracy = HRLFloat(0.0)
    }

    func emptyDataFrame() -> DataFrame {
        return DataFrame()
    }

    func nonEmptyDataFrame() -> DataFrame {
        let dataFrame = DataFrame()

        var date = Date()
        for _ in 0..<7 {
            for _ in 0..<Constants.minRecordsPerWeekday {
                dataFrame.append(record: HelperRecord.makeRecord(at: date), isWorkingOut: false)
            }

            date = HelperDate.nextDay(to: date)
        }

        return dataFrame
    }
}
