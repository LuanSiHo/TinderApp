//
//  TestStringExtension.swift
//  TinderAppTests
//
//  Created by Ho Si Luan on 9/25/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
@testable import TinderApp

class TestStringExtension: XCTestCase {
    func testLoadUrlWithPrefixEndpoint() {
        let prefixEndpoint = "/api"
        let url = prefixEndpoint.url()
        XCTAssertEqual(url, "\(Config.domain)/api")
    }
    
    func testLoadUrlWithoutPrefixEndpoint() {
        let endpoint = "api"
        let url = endpoint.url()
        XCTAssertEqual(url, "\(Config.domain)/api")
    }
    
    func testCreateProductDetailDomainWithProductId() {
        let endpoint = TinderListUriType.productDetail.with(productId: "123")
        let url = endpoint.url()
        XCTAssertEqual(url, "\(Config.domain)/123/detail")
    }
    
    func testConvertISO8601ToFullDateFormat() {
        let stringISO8601 = "1962-11-22T12:37:38.605Z"
        let date = stringISO8601.convertToDateWithFormmatter(DateFormatName.ISO8601FormatDate)
        let dateString = date.convertToCustomFormatter(DateFormatName.fullDate)
        XCTAssertEqual(dateString, "22/11/1962")
    }
    
    func testConvertWrongISO8601ToFullDateFormat() {
        let stringISO8601 = "1962-11-22T12:37:38"
        let date = stringISO8601.convertToDateWithFormmatter(DateFormatName.ISO8601FormatDate)
        let dateString = date.convertToCustomFormatter(DateFormatName.fullDate)
        
        let today = Date()
        let todayString = today.convertToCustomFormatter(DateFormatName.fullDate)
        
        XCTAssertEqual(dateString, todayString)
    }
    
    func testConvertEmptyISO8601ToFullDateFormat() {
        let stringISO8601 = ""
        let date = stringISO8601.convertToDateWithFormmatter(DateFormatName.ISO8601FormatDate)
        let dateString = date.convertToCustomFormatter(DateFormatName.fullDate)
        
        let today = Date()
        let todayString = today.convertToCustomFormatter(DateFormatName.fullDate)
        XCTAssertEqual(dateString, todayString)
    }
}
