//
//  GomokuMinMaxTests.swift
//  GomokuTests
//
//  Created by Mike Laursen on 12/16/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import XCTest

class GomokuMinMaxTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEvaluateMinMax() {
        let board = Board()
        let gameNode = GameNode(board: board)
        assignMinMaxScore(gameNode: gameNode)
    }
}
