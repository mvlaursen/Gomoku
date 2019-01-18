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
    
    func testEvaluateMinMax01() {
        // This tests starts with the squares arranged so that the upper, left
        // black (b) stone is on the middle square, and there are four
        // available (a) squares. The min-max algorithm should choose to place
        // a black stone to make four black stones in a row.
        // + + + + + + +
        // + b b b a a +
        // + w w w a a +
        // + + + + + + +
        let ci = Board.centerIndex
        let ci_nextRow = Board.centerIndex + Board.paddedBoardDim
        let moves: [Board.Move] = [
            (.black,  ci), (.white, ci_nextRow),
            (.black, ci + 1), (.white, ci_nextRow + 1),
            (.black, ci + 2), (.white, ci_nextRow + 2)]
        let availableMoveIndices: Set<Int> = [ci + 3, ci + 4, ci_nextRow + 3, ci_nextRow + 4]
        let board = Board(moves: moves, availableMoveIndices: availableMoveIndices)
        let gameNode = GameNode(board: board)
        
        let chosenGameNode = minMaxMoveChooserAux(gameNode: gameNode, depth: 2)
        XCTAssertEqual(gameNode.score, 1)
        XCTAssertNotNil(chosenGameNode)
        XCTAssertEqual(chosenGameNode!.score, 1)
        XCTAssertNotNil(chosenGameNode!.board.mostRecentMove)
        XCTAssert(chosenGameNode!.board.mostRecentMove!.index == ci + 3
            || chosenGameNode!.board.mostRecentMove!.index == ci_nextRow + 3,
            "chosen move index: \(chosenGameNode!.board.mostRecentMove!.index)")
    }
    
//    func testEvaluateMinMax02() {
//        // This tests starts with the squares arranged as pictured:
//        // a a a a a + +
//        // a b b b w + +
//        // a a w w a + +
//        // + + + + + + +
//        let ci = Board.middleMoveIndex
//        let ci_nextRow = Board.middleMoveIndex + Board.paddedBoardDim
//        let moves: [Board.Move] = [
//            (.black,  ci), (.white, ci_nextRow + 1),
//            (.black, ci + 1), (.white, ci_nextRow + 2),
//            (.black, ci + 2), (.white, ci + 3)]
//        let availableMoveIndices: Set<Int> = [
//            ci - 24, ci - 23, ci - 22, ci - 21, ci - 20,
//            ci - 1,
//            ci_nextRow - 1, ci_nextRow, ci_nextRow + 3]
//        let board = Board(moves: moves, availableMoveIndices: availableMoveIndices)
//        let gameNode = GameNode(board: board)
//        
//        let chosenGameNode = minMaxMoveChooserAux(gameNode: gameNode, depth: 2)
//        XCTAssertEqual(gameNode.score, 1)
//        XCTAssertNotNil(chosenGameNode)
//        XCTAssertEqual(chosenGameNode!.score, 1)
//        XCTAssertNotNil(chosenGameNode!.board.mostRecentMove)
//        XCTAssert(chosenGameNode!.board.mostRecentMove!.index == ci - 22,
//            "chosen move index: \(chosenGameNode!.board.mostRecentMove!.index)")
//    }
}
