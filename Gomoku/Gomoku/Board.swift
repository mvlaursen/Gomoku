//
//  Board.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

enum Square {
    case empty
    case black
    case white
}

struct Board {
    static let boardSize = 15
    
    let availableMoves: Set<Int>
    let squares: [Square]
    
    init() {
        let numSquares = Board.boardSize * Board.boardSize
        availableMoves = Set(Array<Int>.init(0..<numSquares))
        squares = Array(repeating: .empty, count: numSquares)
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
