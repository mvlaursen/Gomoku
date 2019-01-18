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
        
        XCTAssert(Board.centerIndex == 264)
        let result000 = game.generateRunIndicesList(moveIndex: Board.centerIndex)
        XCTAssertTrue(result000.count == 20)
    }
    
    func testWinDetection() {
        let game = Game()
        let b0 = game.doBlackMove()
        XCTAssert(b0 != nil && b0 == 264)
        let w0 = game.doWhiteMove()
        XCTAssert(w0 != nil)
        let b1 = game.doBlackMove()
        XCTAssert(b1 != nil)
        XCTAssertFalse(game.didWin(moveIndex: b1!))
    }
}
