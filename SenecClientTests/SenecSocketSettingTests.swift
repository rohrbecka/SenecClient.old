//
//  SenecSocketTests.swift
//  SenecClientTests
//
//  Created by André Rohrbeck on 18.10.18.
//

import XCTest
@testable import SenecClient

class SenecSocketSettingTests: XCTestCase {

    func testConstructor () {
        let trigger = SenecSocketSetting.AutomaticSocketModeTrigger(minTime: 10,
                                                                    minPower: 20,
                                                                    onTime: 30,
                                                                    maxTime: 40)
        let status = SenecSocketSetting.SocketStatus(powerOn: true,
                                                     timeRemaining: 100)
        let forcedSut = SenecSocketSetting(mode: .forced,
                                           trigger: trigger,
                                           status: status)


        let expectedTrigger = trigger
        let expectedStatus = status
        XCTAssertEqual(forcedSut.mode, .forced)
        XCTAssertEqual(forcedSut.trigger, expectedTrigger)
        XCTAssertEqual(forcedSut.status, expectedStatus)
    }



    func testConstructor1 () {
        let trigger = SenecSocketSetting.AutomaticSocketModeTrigger(minTime: 100,
                                                                    minPower: 200,
                                                                    onTime: 300,
                                                                    maxTime: 400)
        let status = SenecSocketSetting.SocketStatus(powerOn: false,
                                                     timeRemaining: 0)
        let automaticSut = SenecSocketSetting(mode: .automatic,
                                              trigger: trigger,
                                              status: status)


        let expectedTrigger = trigger
        let expectedStatus = status
        XCTAssertEqual(automaticSut.mode, .automatic)
        XCTAssertEqual(automaticSut.trigger, expectedTrigger)
        XCTAssertEqual(automaticSut.status, expectedStatus)
    }



    func testConstructor2 () {
        let trigger = SenecSocketSetting.AutomaticSocketModeTrigger(minTime: 1,
                                                                    minPower: 2,
                                                                    onTime: 3,
                                                                    maxTime: 4)
        let status = SenecSocketSetting.SocketStatus(powerOn: true,
                                                     timeRemaining: 1)
        let offSut = SenecSocketSetting(mode: .off,
                                              trigger: trigger,
                                              status: status)


        let expectedTrigger = trigger
        let expectedStatus = status
        XCTAssertEqual(offSut.mode, .off)
        XCTAssertEqual(offSut.trigger, expectedTrigger)
        XCTAssertEqual(offSut.status, expectedStatus)
    }



    // MARK: - AutomaticSocketModeTrigger
    func testTriggerConstructor () {
        let trigger = SenecSocketSetting.AutomaticSocketModeTrigger(minTime: 1, minPower: 2, onTime: 3, maxTime: 4)
        XCTAssertEqual(trigger.minTime, 1)
        XCTAssertEqual(trigger.maxTime, 4)
        XCTAssertEqual(trigger.minPower, 2)
        XCTAssertEqual(trigger.onTime, 3)
    }



    func testTriggerConstructor1 () {
        let trigger = SenecSocketSetting.AutomaticSocketModeTrigger(minTime: 10, minPower: 20, onTime: 30, maxTime: 40)
        XCTAssertEqual(trigger.minTime, 10)
        XCTAssertEqual(trigger.maxTime, 40)
        XCTAssertEqual(trigger.minPower, 20)
        XCTAssertEqual(trigger.onTime, 30)
    }



    // MARK: - SocketStatus
    func testSocketStatusConstructor () {
        let status = SenecSocketSetting.SocketStatus(powerOn: true, timeRemaining: 100)
        XCTAssertEqual(status.powerOn, true)
        XCTAssertEqual(status.timeRemaining, 100)
    }



    func testSocketStatusConstructor1 () {
        let status = SenecSocketSetting.SocketStatus(powerOn: false, timeRemaining: 0)
        XCTAssertEqual(status.powerOn, false)
        XCTAssertEqual(status.timeRemaining, 0)
    }

}
