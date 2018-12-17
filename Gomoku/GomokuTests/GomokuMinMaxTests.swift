//
//  GomokuMinMaxTests.swift
//  GomokuTests
//
//  Created by Mike Laursen on 12/16/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import XCTest

extension Board {
    /**
     Board initializer for setting up test scenarios.
     
     - Parameters:
       - moves: This list of Moves is applied to a board that starts out with
           `.empty` squares in the playable area, `.outofbounds` squares in the
           padding areas.
       - availableMoveIndices: It is OK to set up a set of available move
           indices that does not include every `.empty` space left on the
           board. It can be useful for testing to have only a few, one, or no
           choice of available moves. The initializer checks that all indices
           in `availableMoveIndices` refer to `.empty` squares.
    */
    init(moves: [Move], availableMoveIndices: Set<Int>) {
        let startingBoard = Board()
        
        var mutableSquares = startingBoard.squares
        for move in moves {
            precondition(move.mover == .black || move.mover == .white)
            mutableSquares[move.index] = move.mover
        }
        self.squares = mutableSquares
        self.mostRecentMove = moves.last
        
        self.availableMoveIndices = availableMoveIndices
        precondition(self.availableMoveIndices.allSatisfy({ (index) -> Bool in
            self.squares[index] == .empty
        }))
    }
}

class GomokuMinMaxTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEvaluateMinMax() {
        let moves: [Board.Move] = [(.black, Board.middleMoveIndex), (.white, Board.middleMoveIndex + 1)]
        let availableMoveIndices: Set<Int> = [Board.middleMoveIndex + 2]
        let board = Board(moves: moves, availableMoveIndices: availableMoveIndices)
        let gameNode = GameNode(board: board)
        assignMinMaxScore(gameNode: gameNode)
        XCTAssert(gameNode.score == 0)
    }
}
