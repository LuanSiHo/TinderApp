//
//  TinderAppUITests.swift
//  TinderAppUITests
//
//  Created by Ho Si Luan on 9/25/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
import TinderApp

class TinderAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func testOpenFavoriteList() {
        let heartButton = app.navigationBars["Tinder List"].buttons["iconHeart"]
        let backButton = app.navigationBars["Favorite List"].buttons["iconBack"]
        
        heartButton.tap()
        XCTAssertTrue(backButton.exists)
        backButton.tap()
        XCTAssertTrue(heartButton.exists)
        
    }
    
    func testCheckEnableReloadButton() {
        let reloadButton = app.navigationBars["Tinder List"].buttons["iconReload"]
        XCTAssertTrue(reloadButton.isEnabled)
    }
}

