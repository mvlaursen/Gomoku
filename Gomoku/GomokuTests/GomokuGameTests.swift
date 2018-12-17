//
//  GomokuGameTests.swift
//  GomokuTests
//
//  Created by Mike Laursen on 12/16/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import XCTest

class GomokuGameTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRunGeneration() {
        let game = Game()
        
        XCTAssert(Board.middleMoveIndex == 264)
        let result000 = game.generateRunIndicesList(moveIndex: Board.middleMoveIndex)
        XCTAssertTrue(result000.count == 20)
    }
}
