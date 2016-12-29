//
//  WorkingOutTest.swift
//  HRLClassifier
//
//  Created by Enrique de la Torre (dev) on 27/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

@testable import HRLClassifier

class WorkingOutTest: XCTestCase {
    func testBoolTrue_init_returnWorkingOutTrue() {
        XCTAssertEqual(WorkingOut(true), WorkingOut.true)
    }

    func testBoolFalse_init_returnWorkingOutFalse() {
        XCTAssertEqual(WorkingOut(false), WorkingOut.false)
    }

    func testWorkingOutTrue_init_returnBoolTrue() {
        XCTAssertTrue(Bool(WorkingOut.true))
    }

    func testWorkingOutFalse_init_returnBoolFalse() {
        XCTAssertFalse(Bool(WorkingOut.false))
    }
}
