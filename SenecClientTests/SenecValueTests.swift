//
//  SenecValueTests.swift
//  SenecClientTests
//
//  Created by André Rohrbeck on 07.10.18.
//

import XCTest
@testable import SenecClient

/// Tests the SenecValue type.
///
/// - Author: André Rohrbeck
/// - Copyright: André Rohrbeck © 2018
/// - Date: 2018-10-07
class SenecValueTests: XCTestCase {


    // MARK: - Constructor Tests
    func test_SenecValue_DefaultConstructor() {
        let _ = SenecValue.float(1.2345)
        let _ = SenecValue.uint8(128)
        let _ = SenecValue.uint16(32678)
        let _ = SenecValue.uint32(100000000)
        let _ = SenecValue.uint64(1000000000000)
        let _ = SenecValue.int8(-127)
        let _ = SenecValue.int16(-32677)
        let _ = SenecValue.int32(-100000000)
        let _ = SenecValue.int64(-1000000000000)
    }



    func test_SenecValue_constructsCorrectValue_givenCorrectString () {
        // floating point
        assertCorrectConstruction(with: "fl_409DA112", expected: .float(4.925912013758661))

        // unsigned ints
        assertCorrectConstruction(with: "u8_0c", expected: .uint8(12))
        assertCorrectConstruction(with: "u1_0c45", expected: .uint16(3141))
        assertCorrectConstruction(with: "u3_c456fe38", expected: .uint32(3_294_035_512))
        assertCorrectConstruction(with: "u6_c456fe38c456fe38", expected: .uint64(0xc456fe38c456fe38))

        // signed ints
        assertCorrectConstruction(with: "i8_ff", expected: .int8(-1))
        assertCorrectConstruction(with: "i1_ffff", expected: .int16(-1))
        assertCorrectConstruction(with: "i3_FFFFFFFF", expected: .int32(-1))
        assertCorrectConstruction(with: "i6_FFFFFFFFFFFFFFFF", expected: .int64(-1))

        // strings and characters
        // This is not implemented yet, as no example could be found while analyzing the Senec JSON API.
    }



    func test_SenecValue_constructorReturnsNil_givenIllegalString () {
        assertCorrectConstruction(with: "affe", expected: nil, "The senec type prefix is missing.")
        assertCorrectConstruction(with: "fl_hello", expected: nil, "hello isn't a valid hex string.")
        assertCorrectConstruction(with: "u8_beef", expected: nil, "beef is too long for a uint8 value.")
        // TODO: add more tests
    }


    // MARK: - Test retreival of wrapped value.
    


    // MARK: - Helper functions
    private func assertCorrectConstruction(with string: String,
                                                  expected: SenecValue?,
                                                  _ message: String = "",
                                                  file: StaticString = #file,
                                                  line: UInt = #line) {
        let value = SenecValue(string: string)
        XCTAssertEqual(expected, value, message, file: file, line: line)
    }
}
