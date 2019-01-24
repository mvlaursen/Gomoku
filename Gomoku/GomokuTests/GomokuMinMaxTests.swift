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
            mutableSquares[move.index] = move.mover.toSquare()
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
    
    func testEvaluateMinMax01() {
        // This tests starts with the squares arranged so that the upper, left
        // black (b) stone is on the middle square, and there are four
        // available (.) squares:
        //
        //    x x x x x x x
        //    x b b b . . x
        //    x w w w . . x
        //    x x x x x x x
        //
        // Because the generation of moves to be considered is randomized,
        // there is more than one possible correct outcome for this test.
        
        let ci = Board.centerIndex
        let ci_nextRow = Board.centerIndex + Board.paddedSquaresPerDim
        let moves: [Board.Move] = [
            (Player.black,  ci), (Player.white, ci_nextRow),
            (Player.black, ci + 1), (Player.white, ci_nextRow + 1),
            (Player.black, ci + 2), (Player.white, ci_nextRow + 2)]
        let availableMoveIndices: Set<Int> = [ci + 3, ci + 4, ci_nextRow + 3, ci_nextRow + 4]
        let board = Board(moves: moves, availableMoveIndices: availableMoveIndices)
        let gameNode = GameNode(board: board)
        
        let chosenGameNode = MinMaxMoveChooser.chooseNextMoveAux(gameNode: gameNode, depth: 2)
        XCTAssertEqual(gameNode.score, 1)
        XCTAssertNotNil(chosenGameNode)
        XCTAssertEqual(chosenGameNode!.score, 1)
        XCTAssertNotNil(chosenGameNode!.board.mostRecentMove)
        XCTAssert(chosenGameNode!.board.mostRecentMove!.index == ci + 3
            || chosenGameNode!.board.mostRecentMove!.index == ci_nextRow + 3,
            "chosen move index: \(chosenGameNode!.board.mostRecentMove!.index)")
    }    
}
