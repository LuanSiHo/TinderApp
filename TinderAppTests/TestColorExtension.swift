//
//  TestColorExtension.swift
//  TinderAppTests
//
//  Created by Ho Si Luan on 9/25/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
@testable import TinderApp

class TestColorExtension: XCTestCase {

    func testCreateColorFromEmptyHexString() {
        let color = UIColor.init(hex: "")
        XCTAssertNotNil(color)
    }

    func testCreateColorFromShortHexString() {
        let color = UIColor.init(hex: "#ff0")
        XCTAssertNotNil(color)
    }
}
