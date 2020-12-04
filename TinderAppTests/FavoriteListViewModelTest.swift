//
//  FavoriteListViewModelTest.swift
//  TinderAppTests
//
//  Created by Ho Si Luan on 12/4/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import XCTest
@testable import TinderApp

class FavoriteListViewModelTest: XCTestCase {
    
    class TestClass: FavoriteListViewModelDelegate {
        var isShowLoadingView: Bool = false
        var isShowingEmptyView: Bool = false
        var isReloadData: Bool = false
        
        func hideRefreshControl() {}
        
        func reloadData() {
            isReloadData = true
        }
        
        func showErrorView(error: ErrorType) {}
        
        func showLoadingView() {
            isShowLoadingView = true
        }
        
        func hideLoadingView() {}
        
        func showNoDataView() {
            isShowingEmptyView = true
        }
        
        func hideNoDataView() {
            isShowingEmptyView = false
        }
    }
    
    var viewModel: FavoriteListViewModel?
    let testClass = TestClass()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = FavoriteListViewModel(delegate: testClass)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testShowLoadingView() {
        viewModel?.getLocalFavoriteList(type: .fetch, by: LocalFavoriteListManager.shared)
        XCTAssert(testClass.isShowLoadingView, "must show loading view when fetching data")
    }
    
    func testLocalDataIsEmpty() {
        try? LocalFavoriteListManager.shared.removeAll()
        viewModel?.getLocalFavoriteList(type: .fetch, by: LocalFavoriteListManager.shared)
        XCTAssert(viewModel?.favoriteList.isEmpty ?? false, "local favorite list is empty now")
        XCTAssert(testClass.isShowingEmptyView, "must show empty view")
        XCTAssert(testClass.isReloadData, "must reload data after fetching")
    }
    
    func testLocalDataIsNotEmpty() {
        try? LocalFavoriteListManager.shared.add(user: UserModel(JSON: [:])!)
        viewModel?.getLocalFavoriteList(type: .fetch, by: LocalFavoriteListManager.shared)
        XCTAssert(!(viewModel?.favoriteList.isEmpty ?? false), "local favorite list is not empty now")
        XCTAssert(!testClass.isShowingEmptyView, "don't show empty view")
        XCTAssert(testClass.isReloadData, "must reload data after fetching")
    }
}
