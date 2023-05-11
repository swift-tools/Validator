//
//  ValidatorTests.swift
//  Validator_Tests
//
//  Created by Felix Chacaltana on 11/05/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import Validator

final class ValidatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsNotValidResult() throws {
        let validator = Validator()
        validator.addValidation(RequiredValidation())
        let sut = validator.validate("")
        XCTAssertFalse(sut.isValid)
        XCTAssertNotNil(sut.error)
    }
    
    func testIsValidResult() throws {
        let validator = Validator()
        validator.addValidation(RequiredValidation())
        let sut = validator.validate("Hello World!")
        XCTAssertTrue(sut.isValid)
        XCTAssertNil(sut.error)
    }
    
    func testIsNotValidResultError() throws {
        let validator = Validator()
        let required = RequiredValidation()
        validator.addValidation(required)
        let result = validator.validate("")
        let sut = result.error!
        XCTAssertEqual(sut.errorKey, required.errorKey)
        XCTAssertEqual(sut.errorMessage, required.errorMessage)
    }
    
    func testIsNotValidResultCustomErrorMessage() throws {
        let validator = Validator()
        let required = RequiredValidation()
        let customErrorMessage = "Custom error message!"
        validator.addValidation(required, errorMessage: customErrorMessage)
        let result = validator.validate("")
        let sut = result.error!
        XCTAssertEqual(sut.errorMessage, customErrorMessage)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
