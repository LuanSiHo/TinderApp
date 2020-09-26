//
//  TestFontExtension.swift
//  TinderAppTests
//
//  Created by Ho Si Luan on 9/25/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
@testable import TinderApp

class TestFontExtension: XCTestCase {
    
    func testCreateSytemFont() {
        let fontSize: CGFloat = 18
        let systemFont = FontName.systemFont(ofSize: fontSize)
        
        XCTAssertEqual(systemFont, UIFont.systemFont(ofSize: fontSize))
    }
    
    func testCreateBoldSystemFont() {
        let fontSize: CGFloat = 18
        let systemFont = FontName.boldSystemFont(ofSize: fontSize)
        
        XCTAssertEqual(systemFont, UIFont.boldSystemFont(ofSize: fontSize))
    }
}
