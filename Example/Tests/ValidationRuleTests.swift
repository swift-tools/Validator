//
//  ValidationRuleTests.swift
//  Validator_Tests
//
//  Created by lazymisu on 11/05/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import Validator

final class ValidationRuleTests: XCTestCase {
    
    func testRequired() throws {
        let sut = ValidationRule.Required()
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertTrue(sut.validate("a"))
        XCTAssertTrue(sut.validate(" Hello"))
        XCTAssertTrue(sut.validate("World "))
        XCTAssertTrue(sut.validate("123"))
    }
    
    func testEmail() throws {
        let sut = ValidationRule.Email()
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertFalse(sut.validate("   @   .   "))
        XCTAssertFalse(sut.validate("123@123.123"))
        XCTAssertTrue(sut.validate("123@asdf.as"))
        XCTAssertTrue(sut.validate("john@doe.com"))
    }

    func testPhonePE() throws {
        let sut = ValidationRule.PhonePE()
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate("abcdefghi"))
        XCTAssertFalse(sut.validate("123456789"))
        XCTAssertFalse(sut.validate("987abc123"))
        XCTAssertFalse(sut.validate("987 654 321"))
        XCTAssertFalse(sut.validate("+51 987654321"))
        XCTAssertFalse(sut.validate("+987654321"))
        XCTAssertFalse(sut.validate("9876543210"))
        XCTAssertTrue(sut.validate("+51987654321"))
        XCTAssertTrue(sut.validate("987654321"))
    }

    func testAlpha() throws {
        let sut = ValidationRule.Alpha()
        XCTAssertFalse(sut.validate("H3ll0"))
        XCTAssertFalse(sut.validate("Hello World"))
        XCTAssertFalse(sut.validate("こんにちは"))
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertFalse(sut.validate("123"))
        XCTAssertFalse(sut.validate("!@#$"))
        XCTAssertTrue(sut.validate("Hello"))
        XCTAssertTrue(sut.validate("HELLO"))
        XCTAssertTrue(sut.validate("hello"))
    }
    
    func testAlphaNum() throws {
        let sut = ValidationRule.AlphaNum()
        XCTAssertTrue(sut.validate("H3ll0"))
        XCTAssertFalse(sut.validate("Hello World"))
        XCTAssertFalse(sut.validate("こんにちは"))
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertTrue(sut.validate("123"))
        XCTAssertFalse(sut.validate("!@#$"))
        XCTAssertTrue(sut.validate("Hello"))
        XCTAssertTrue(sut.validate("HELLO"))
        XCTAssertTrue(sut.validate("hello"))
    }
    
    func testNoSpecialChars() throws {
        let sut = ValidationRule.NoSpecialChars()
        XCTAssertTrue(sut.validate("Hello"))
        XCTAssertTrue(sut.validate("HELLO"))
        XCTAssertTrue(sut.validate("hello"))
        XCTAssertTrue(sut.validate("H3ll0"))
        XCTAssertFalse(sut.validate("Hello World"))
        XCTAssertFalse(sut.validate("こんにちは"))
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertTrue(sut.validate("123"))
        XCTAssertFalse(sut.validate("!@#$"))
    }
    
    func testLowerCase() throws {
        let sut = ValidationRule.LowerCase()
        XCTAssertTrue(sut.validate("hello"))
        XCTAssertFalse(sut.validate("hELLO"))
        XCTAssertFalse(sut.validate("HELLO"))
        XCTAssertFalse(sut.validate("H3ll0"))
        XCTAssertFalse(sut.validate("Hello World"))
        XCTAssertFalse(sut.validate("こんにちは"))
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertFalse(sut.validate("123"))
        XCTAssertFalse(sut.validate("!@#$"))
    }
    
    func testUpperCase() throws {
        let sut = ValidationRule.UpperCase()
        XCTAssertTrue(sut.validate("HELLO"))
        XCTAssertFalse(sut.validate("hELLO"))
        XCTAssertFalse(sut.validate("hello"))
        XCTAssertFalse(sut.validate("H3ll0"))
        XCTAssertFalse(sut.validate("Hello World"))
        XCTAssertFalse(sut.validate("こんにちは"))
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertFalse(sut.validate("123"))
        XCTAssertFalse(sut.validate("!@#$"))
    }
    
    func testNumeric() throws {
        let sut = ValidationRule.Numeric()
        XCTAssertTrue(sut.validate("12345"))
        XCTAssertTrue(sut.validate("9876543210"))
        XCTAssertTrue(sut.validate("1"))
        XCTAssertTrue(sut.validate("0"))
        XCTAssertFalse(sut.validate("123456789a"))
        XCTAssertFalse(sut.validate(""))
        XCTAssertFalse(sut.validate(" "))
        XCTAssertFalse(sut.validate("1.23"))
        XCTAssertFalse(sut.validate("1,234"))
        XCTAssertFalse(sut.validate("1-23"))
    }
    
    func testMinMaxLength() throws {
        let sut = ValidationRule.Length(min: 5, max: 10)
        let sut2 = ValidationRule.Length(min: 1, max: 1)
        let sut3 = ValidationRule.Length(min: 0, max: 10)
        let sut4 = ValidationRule.Length(min: 1, max: 10)
        XCTAssertTrue(sut.validate("abcde"))
        XCTAssertFalse(sut.validate("1234"))
        XCTAssertFalse(sut.validate("abcdefghijklmno"))
        XCTAssertTrue(sut.validate("!@#$%^&*()"))
        XCTAssertTrue(sut.validate("a b c d e"))
        XCTAssertTrue(sut2.validate("a"))
        XCTAssertTrue(sut3.validate("abcde"))
        XCTAssertFalse(sut4.validate(""))
        XCTAssertTrue(sut4.validate(" "))
    }
}
