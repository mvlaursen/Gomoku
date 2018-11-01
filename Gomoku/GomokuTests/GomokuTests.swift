//
//  GomokuTests.swift
//  GomokuTests
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import XCTest
@testable import Gomoku

class GomokuTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testRunGeneration() {
        let game = Game()
        
//        let result000 = game.generateListOfRunIndices(moveIndex: 0)
//        XCTAssertTrue(result000.count == 3)
        
//        let result008 = game.generateListOfRunIndices(moveIndex: 8)
//        XCTAssertTrue(result008.count == 8)
        
        game.kahoona()
        
    }

}
