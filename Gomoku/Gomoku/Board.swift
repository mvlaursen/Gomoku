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
    
    let squares: [[Square]]
    
    init() {
        squares = Array(repeating: Array(repeating: .empty, count: Board.boardSize), count: Board.boardSize)
    }
    
    init(board other: Board, row: Int, column: Int, square: Square) {
        var newSquares = other.squares
        newSquares[row][column] = square
        self.squares = newSquares
    }
}
