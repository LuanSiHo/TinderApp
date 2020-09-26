//
//  TinderAppTests.swift
//  TinderAppTests
//
//  Created by Ho Si Luan on 9/24/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
@testable import TinderApp

class TinderAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension TinderAppTests {

}

extension TinderAppTests {

}

extension TinderAppTests {
    class TestClass: BaseProtocol {}
    
    func testGetTinderList() {
       let testClass = TestClass()
        let param = UserListParam()
        param.numberOfResult = 10
        let promise = expectation(description: "return success")
        
        let apiService = TinderListApiService(delegate: testClass)
        apiService.loadUserList(param: param) { (response) in
            switch response {
            case .success(_):
                promise.fulfill()
                break
            case .failure(let error):
                XCTFail("Error: \(error.message)")
                break
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}

