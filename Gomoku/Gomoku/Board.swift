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
    static let boardSize = 15
    static let extendedBoardSize = 23
    static let lowerBound = 4
    static let runLength = 5
    static let upperBound = 18
    
    let availableMoves: Set<Int>
    let squares: [Square]
    
    init() {
        var mutableAvailableMoves = Set<Int>()
        var mutableSquares = Array<Square>(repeating: .outofbounds, count: 23 * 23)
        
        for row in Board.lowerBound...Board.upperBound {
            for column in Board.lowerBound...Board.upperBound {
                    let index = row * Board.extendedBoardSize + column
                    mutableSquares[index] = .empty
                    mutableAvailableMoves.insert(row * Board.extendedBoardSize + column)
            }
        }
        
        self.availableMoves = mutableAvailableMoves
        self.squares = mutableSquares
    }
    
    init(board other: Board, index: Int, square: Square) {
        // TODO Protect against bad index.
        
        var newAvailableMoves = other.availableMoves
        newAvailableMoves.remove(index)
        self.availableMoves = newAvailableMoves
        
        var newSquares = other.squares
        newSquares[index] = square
        self.squares = newSquares
    }
}
