//
//  TestUImageExtension.swift
//  TinderAppTests
//
//  Created by Ho Si Luan on 9/25/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
@testable import TinderApp

class TestUImageExtension: XCTestCase {
    func testLoadEmptyImage() {
        let imageName = ""
        let image = UIImage.bundleImage(named: imageName)
        XCTAssertNotNil(image)
    }
}
