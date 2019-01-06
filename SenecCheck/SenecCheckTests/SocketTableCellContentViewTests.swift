//
//  SocketTableCellContentView.swift
//  SenecCheckTests
//
//  Created by André Rohrbeck on 01.01.19.
//  Copyright © 2019 André Rohrbeck. All rights reserved.
//

import XCTest
@testable import SenecCheck

class SocketTableCellContentViewTests: XCTestCase {


    func testSocketTableCellContentViewIsUIView () {
        let sut: Any = SocketTableCellView()
        XCTAssert(sut is UIView)
    }

    func testAfterElementsSubviewsArePresent() {
        let sut = SocketTableCellView()
        XCTAssert (sut.nameLabel as Any is UILabel)
        XCTAssert (sut.modeControl as Any is UISegmentedControl)
        XCTAssert (sut.statusIcon as Any is UIView)
        XCTAssert (sut.statusTimeLabel as Any is UILabel)
    }


    func test_AfterInit_UIElementsArePresentAsSubviews() {
        let sut = SocketTableCellView()
        XCTAssert(sut.subviews.contains(sut.nameLabel))
        XCTAssert(sut.subviews.contains(sut.modeControl))
        XCTAssert(sut.subviews.contains(sut.statusIcon))
        XCTAssert(sut.subviews.contains(sut.statusTimeLabel))
    }


    func test_AfterInit_SegmentedControlFeaturesTheCorrectSegments () {
        let sut = SocketTableCellView()
        XCTAssertEqual(sut.modeControl.numberOfSegments, 4)
        XCTAssertEqual(sut.modeControl.titleForSegment(at: 0), "Off")
        XCTAssertEqual(sut.modeControl.titleForSegment(at: 1), "Auto")
        XCTAssertEqual(sut.modeControl.titleForSegment(at: 2), "Time")
        XCTAssertEqual(sut.modeControl.titleForSegment(at: 3), "On")
    }


    func test_afterInit_allObjectsAreSetToIgnoreAutoresizingMask () {
        let sut = SocketTableCellView()
        XCTAssertFalse(sut.modeControl.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(sut.nameLabel.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(sut.statusIcon.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(sut.statusTimeLabel.translatesAutoresizingMaskIntoConstraints)
    }



    // MARK: - View Model setting
    func test_SettingViewModel_setsUpContentCorrectly () {
        let sut = SocketTableCellView()
        let viewModel = ViewModel (socketName: "Hello",
                                   selectedModeIndex: 3,
                                   powerOn: false,
                                   remainingTimeString: "00:00")
        sut.viewModel = viewModel

        XCTAssertEqual(sut.nameLabel.text, "Hello")
        let selectedIndex = sut.modeControl.selectedSegmentIndex
        if selectedIndex == UISegmentedControl.noSegment {
            XCTFail("No segment slected in modeControl, but 'on' should be selected!")
        } else {
            XCTAssertEqual(SenecSocketMode.allCases[selectedIndex], SenecSocketMode.on)
        }
        XCTAssert(sut.statusTimeLabel.isHidden)
    }
}



public struct ViewModel: SocketTableCellPresentable {
    public let socketName: String

    public var sortedModes: [SocketMode] {
        return SenecSocketMode.allCases
    }

    public var selectedModeIndex: Int

    public let powerOn: Bool

    public var remainingTimeString: String



}
