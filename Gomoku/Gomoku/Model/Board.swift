//
//  Board.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

struct Board {
    typealias Move = (mover: Square, index: Int)
    
    static let paddedBoardDim = GameConfiguration.boardDim + 2 * (GameConfiguration.winningRunLength - 1)
    // The lower and upper bounds are included in the playable board area.
    static let lowerBound = GameConfiguration.winningRunLength - 1
    static let upperBound = lowerBound + GameConfiguration.boardDim - 1
    
    let availableMoveIndices: Set<Int>
    let mostRecentMove: Move?
    // Even though a Gomoku board is two-dimensional, modeling the board as a
    // one-dimensional array makes some things easier, such as keeping a list
    // of moves that are still available, using higher order array functions to
    // check for winning runs, etc.
    let squares: [Square]
    
    static func indexFrom(row: Int, column: Int) -> Int {
        // TODO: Get rid of this precondition by defining a range?
        precondition(row >= 0 && row < Board.paddedBoardDim)
        precondition(column >= 0 && column < Board.paddedBoardDim)
        
        return row * Board.paddedBoardDim + column
    }

    init() {
        var mutableAvailableMoveIndices = Set<Int>()
        var mutableSquares = Array<Square>(repeating: .outofbounds,
            count: Board.paddedBoardDim * Board.paddedBoardDim)
        
        for row in Board.lowerBound...Board.upperBound {
            for column in Board.lowerBound...Board.upperBound {
                    let index = Board.indexFrom(row: row, column: column)
                    mutableAvailableMoveIndices.insert(row * Board.paddedBoardDim + column)
                    mutableSquares[index] = .empty
            }
        }
        
        self.availableMoveIndices = mutableAvailableMoveIndices
        self.mostRecentMove = nil
        self.squares = mutableSquares
    }
    
    init(board other: Board, index: Int) {
        precondition(index > 0 && index < other.squares.count)
        
        var mover = Square.black
        if let mostRecentMove = other.mostRecentMove {
            mover = mostRecentMove.mover == Square.black ? Square.white : Square.black
        }
        self.mostRecentMove = (mover: mover, index: index)
        
        var newAvailableMoves = other.availableMoveIndices
        newAvailableMoves.remove(index)
        self.availableMoveIndices = newAvailableMoves
        
        var newSquares = other.squares
        newSquares[index] = mover
        self.squares = newSquares
    }
}
