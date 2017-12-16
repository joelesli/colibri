//
//  NetworkHelperTests.swift
//  colibri-apiTests
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import XCTest
@testable import colibri_api

class NetworkHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetSystems() {
        
        weak var expectation =  self.expectation(description: "Systes received")
        
        let netHelper = NetworkHelper()
        netHelper.getSystems(parameters: [:]) { (results) in
            expectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { (error) -> Void in
            XCTAssert(error == nil, "Error: \(error ?? NSError())")
        }
    }
    
}
