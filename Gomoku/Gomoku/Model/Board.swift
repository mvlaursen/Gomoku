//
//  Board.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

enum Square {
    case outofbounds
    case empty
    case black
    case white
}

struct Board {
    static let runLength = 5
    static let playableBoardDim = 15
    static let paddedBoardDim = playableBoardDim + 2 * (runLength - 1)
    // The lower and upper bounds are included in the playable board area.
    static let lowerBound = runLength - 1
    static let upperBound = lowerBound + playableBoardDim - 1
    
    let availableMoves: Set<Int>
    // Even though a Gomoku board is two-dimensional, modeling the board as a
    // one-dimensional array makes some things easier, such as keeping a list
    // of moves that are still available, using higher order array functions to
    // check for winning runs, etc.
    let squares: [Square]
    
    init() {
        var mutableAvailableMoves = Set<Int>()
        var mutableSquares = Array<Square>(repeating: .outofbounds,
            count: Board.paddedBoardDim * Board.paddedBoardDim)
        
        for row in Board.lowerBound...Board.upperBound {
            for column in Board.lowerBound...Board.upperBound {
                    let index = row * Board.paddedBoardDim + column
                    mutableSquares[index] = .empty
                    mutableAvailableMoves.insert(row * Board.paddedBoardDim
                        + column)
            }
        }
        
        self.availableMoves = mutableAvailableMoves
        self.squares = mutableSquares
    }
    
    init(board other: Board, index: Int, square: Square) {
        assert(index > 0 && index < other.squares.count)
        
        var newAvailableMoves = other.availableMoves
        newAvailableMoves.remove(index)
        self.availableMoves = newAvailableMoves
        
        var newSquares = other.squares
        newSquares[index] = square
        self.squares = newSquares
    }
}
