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
    
    let netHelper = NetworkHelper()
    
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
        
        weak var expectation =  self.expectation(description: "Systems received")
        
        netHelper.getSystems(parameters: [:]) { (results) in
            XCTAssertTrue(results.count > 0)
            expectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { (error) -> Void in
            XCTAssert(error == nil, "Error: \(error ?? NSError())")
        }
    }
    
    func testGetGPSHistory() {
        
        weak var expectation =  self.expectation(description: "GPS History fetched")
        
        netHelper.getGPSHistory(parameters: ["mac":"00:c0:3a:c9:84:da"]) { (results) in
            dump(results)
            XCTAssertNotNil(results.first as? GPSHistory)
            XCTAssertTrue(results.count > 0)
            expectation?.fulfill()
        }
        
        self.waitForExpectations(timeout: 20) { (error) -> Void in
            XCTAssert(error == nil, "Error: \(error ?? NSError())")
        }
    }
    
}
