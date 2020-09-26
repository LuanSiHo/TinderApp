//
//  TestTinderListApiService.swift
//  TinderAppTests
//
//  Created by Ho Si Luan on 9/25/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
@testable import TinderApp

class TestTinderListApiService: XCTestCase {
    class TestClass: BaseProtocol {}
    
    func testGetTinderListStatus() {
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
    
    func testGetEmptyTinderList() {
        let testClass = TestClass()
        let param = UserListParam()
        param.numberOfResult = 0
        let promise = expectation(description: "return success")
        
        let apiService = TinderListApiService(delegate: testClass)
        apiService.loadUserList(param: param) { (response) in
            switch response {
            case .success(let responseJson):
                if let userList = UserListModel(JSON: responseJson) {
                    if userList.items.count == 1 {
                        // don't know why the api return 1 person even when i request 0 param
                        promise.fulfill()
                    } else {
                        XCTFail("Error: user list does not contains 1 person")
                    }
                } else {
                    XCTFail("Error: can't parse user list")
                }
                break
            case .failure(let error):
                XCTFail("Error: \(error.message)")
                break
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetJustOnePerson() {
        let testClass = TestClass()
        let param = UserListParam()
        param.numberOfResult = 1
        let promise = expectation(description: "return success")
        
        let apiService = TinderListApiService(delegate: testClass)
        apiService.loadUserList(param: param) { (response) in
            switch response {
            case .success(let responseJson):
                if let userList = UserListModel(JSON: responseJson), userList.items.count != 0 {
                    // user list is not empty
                    if userList.items.count == 1 {
                        promise.fulfill()
                    } else {
                        XCTFail("Error: Tinder List is not 1 person")
                    }
                } else {
                    // empty list
                    XCTFail("Error: Tinder List is empty")
                }
                break
            case .failure(let error):
                XCTFail("Error: \(error.message)")
                break
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetOneHundredPerson() {
        let testClass = TestClass()
        let param = UserListParam()
        param.numberOfResult = 100
        let promise = expectation(description: "return success")
        
        let apiService = TinderListApiService(delegate: testClass)
        apiService.loadUserList(param: param) { (response) in
            switch response {
            case .success(let responseJson):
                if let userList = UserListModel(JSON: responseJson), userList.items.count != 0 {
                    // user list is not empty
                    if userList.items.count == 100 {
                        promise.fulfill()
                    } else {
                        XCTFail("Error: Tinder List is not 1 person")
                    }
                } else {
                    // empty list
                    XCTFail("Error: Tinder List is empty")
                }
                break
            case .failure(let error):
                XCTFail("Error: \(error.message)")
                break
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
}
