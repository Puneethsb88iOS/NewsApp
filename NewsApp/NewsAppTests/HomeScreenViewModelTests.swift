//
//  HomeScreenViewModelTests.swift
//  NewsAppTests
//
//  Created by Puneeth SB on 21/04/22.
//

import XCTest
@testable import NewsApp

class HomeScreenViewModelTests: XCTestCase {
    var viewModelUndertest: HomeScreenViewModel!
    var mockCloudService: MockCloudService!
    
    override func setUp() {
        viewModelUndertest = HomeScreenViewModel()
        mockCloudService = MockCloudService()
        DependencyContainer.configureMockCloud(mockCloudService)
    }
    
    func testGetNewsSuccess() {
        //mockCloudService.getNewsResponseSuccess = false
        let expectation = XCTestExpectation(description: "GetNewsSuccess")
        viewModelUndertest.getNewsDetails { result in
            XCTAssertTrue(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(mockCloudService.getNewsResponseSuccess)
        XCTAssertEqual(mockCloudService.getNewsRequestCallCount, 1)
    }
    
    func testGetNewsFailure() {
        mockCloudService.getNewsResponseSuccess = false
        let expectation = XCTestExpectation(description: "GetNewsFailure")
        viewModelUndertest.getNewsDetails { result in
            XCTAssertFalse(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertFalse(mockCloudService.getNewsResponseSuccess)
        XCTAssertEqual(mockCloudService.getNewsRequestCallCount, 1)
    }
}
