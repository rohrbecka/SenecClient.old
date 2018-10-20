//
//  SenecSocketsTests.swift
//  SenecClientTests
//
//  Created by André Rohrbeck on 19.10.18.
//

import XCTest
@testable import SenecClient

/// A Collection of `SenecSocketSetting`s.

class SenecSocketsTests: XCTestCase {

    var autoSocketSetting: SenecSocketSetting = {
        let trigger = SenecSocketSetting.AutomaticSocketModeTrigger (minTime: 10, minPower: 11, onTime: 12, maxTime: 13)
        let status = SenecSocketSetting.SocketStatus(powerOn: true, timeRemaining: 10)
        return SenecSocketSetting(mode: .automatic, trigger: trigger, status: status)
    }()
//
//    var forceSocketSetting =

    var offSocketSetting: SenecSocketSetting = {
		let trigger = SenecSocketSetting.AutomaticSocketModeTrigger (minTime: 10, minPower: 11, onTime: 12, maxTime: 13)
        let status = SenecSocketSetting.SocketStatus(powerOn: false, timeRemaining: 0)
        return SenecSocketSetting(mode: .off, trigger: trigger, status: status)
    }()



    func testConstructor () {
        let sut = SenecSockets (settings: [offSocketSetting])
        XCTAssertEqual(sut[0], offSocketSetting)
    }



    func testConstructor1 () {
        let sut = SenecSockets (settings: [offSocketSetting, autoSocketSetting])

        XCTAssertEqual(sut[0], offSocketSetting)
        XCTAssertEqual(sut[1], autoSocketSetting)
    }



    func testJSONDeserialization () {
        let jsonString = """
        {
            "ENERGY": {
                "GUI_POW_SOCK_0_FORCE_ON": "u8_00",
                "GUI_POW_SOCK_0_ENABLE": "u8_01",
                "GUI_SOCK_0_DATA_MIN_POW": "u1_09C4",
                "GUI_SOCK_0_DATA_MIN_TIME": "u1_0002",
                "GUI_SOCK_0_DATA_ON_TIME": "u1_003C",
                "GUI_SOCK_0_DATA_MAX_TIME": "u1_0000",
                "GUI_POW_SOCK_0_POW_ON": "u8_00",
                "GUI_POW_SOCK_0_TIME_REM": "u1_0000",
                "GUI_POW_SOCK_1_FORCE_ON": "u8_00",
                "GUI_POW_SOCK_1_ENABLE": "u8_00",
                "GUI_SOCK_1_DATA_MIN_POW": "u1_0000",
                "GUI_SOCK_1_DATA_MIN_TIME": "u1_0000",
                "GUI_SOCK_1_DATA_ON_TIME": "u1_0000",
                "GUI_SOCK_1_DATA_MAX_TIME": "u1_0000",
                "GUI_POW_SOCK_1_POW_ON": "u8_01",
                "GUI_POW_SOCK_1_TIME_REM": "u1_0010",
            }
        }
        """

        let sut = decode (SenecSockets.self, json: jsonString)

        let expectedTrigger0 = SenecSocketSetting.AutomaticSocketModeTrigger(minTime: 2,
                                                                             minPower: 2500,
                                                                             onTime: 60,
                                                                             maxTime: 0)
        let expectedStatus0 = SenecSocketSetting.SocketStatus(powerOn: false, timeRemaining: 0)
        let expectedSettings0 = SenecSocketSetting (mode: .automatic,
                                                    trigger: expectedTrigger0,
                                                    status: expectedStatus0)

        let expectedTrigger1 = SenecSocketSetting.AutomaticSocketModeTrigger(minTime: 0,
                                                                             minPower: 0,
                                                                             onTime: 0,
                                                                             maxTime: 0)
        let expectedStatus1 = SenecSocketSetting.SocketStatus(powerOn: true, timeRemaining: 16)
        let expectedSettings1 = SenecSocketSetting(mode: .off, trigger: expectedTrigger1, status: expectedStatus1)

        XCTAssertEqual(sut![0], expectedSettings0)
        XCTAssertEqual(sut![1], expectedSettings1)
    }
}
