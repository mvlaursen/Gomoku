//
//  Game.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/29/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class Game {
    var board: Board = Board()
    
    func doTurn() -> Bool {
        return doWhiteMove() && doBlackMove()
    }
    
    func doBlackMove() -> Bool {
        guard let moveIndex = board.availableMoves.randomElement() else {
            return false
        }
        board = Board(board: board, index: moveIndex, square: .black)
        return true
    }

    func doWhiteMove() -> Bool {
        guard let moveIndex = board.availableMoves.randomElement() else {
            return false
        }
        board = Board(board: board, index: moveIndex, square: .white)
        return true
    }
}
