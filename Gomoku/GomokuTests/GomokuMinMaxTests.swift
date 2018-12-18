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
        // This tests starts with the squares arranged so that the upper, left
        // black stone is on the middle square, and there are four available
        // squares. The min-max algorithm should choose to place a black stone
        // to make four black stones in a row.
        // + + + + + + +
        // + b b b a a +
        // + w w w a a +
        // + + + + + + +
        let mmi = Board.middleMoveIndex
        let mmi_nextRow = Board.middleMoveIndex + Board.paddedBoardDim
        let moves: [Board.Move] = [
            (.black,  mmi), (.white, mmi_nextRow),
            (.black, mmi + 1), (.white, mmi_nextRow + 1),
            (.black, mmi + 2), (.white, mmi_nextRow + 2)]
        let availableMoveIndices: Set<Int> = [mmi + 3, mmi + 4, mmi_nextRow + 3, mmi_nextRow + 4]
        let board = Board(moves: moves, availableMoveIndices: availableMoveIndices)
        let gameNode = GameNode(board: board)
        
        let chosenGameNode = minMaxMoveChooserAux(gameNode: gameNode, depth: 2, maxMovesPerLevel: 4)
        XCTAssertEqual(gameNode.score, 0)
        XCTAssertNotNil(chosenGameNode)
        XCTAssertNotNil(chosenGameNode!.board.mostRecentMove)
        XCTAssert(chosenGameNode!.board.mostRecentMove!.index == mmi + 3,
            "chosen move index: \(chosenGameNode!.board.mostRecentMove!.index)")
    }
}
