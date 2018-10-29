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
    
    func doTurn() {
        if doWhiteMove() {
            doBlackMove()
        }
    }
    
    func doBlackMove() {
        var foundMove = false
        
        for i in 0...board.squares.count {
            for j in 0...board.squares[i].count {
                if board.squares[i][j] == .empty {
                    board = Board(board: self.board, row: i, column: j, square: .black)
                    foundMove = true
                    break
                }
            }
            
            if foundMove {
                break
            }
        }
    }

    func doWhiteMove() -> Bool {
        var foundMove = false
        
        for i in 0...board.squares.count {
            for j in 0...board.squares[i].count {
                if board.squares[i][j] == .empty {
                    board = Board(board: self.board, row: i, column: j, square: .white)
                    foundMove = true
                    break
                }
            }
            
            if foundMove {
                break
            }
        }
        
        return foundMove
    }
}
