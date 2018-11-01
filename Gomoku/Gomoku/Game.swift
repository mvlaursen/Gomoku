//
//  Game.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/29/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class Game {
    static let runIndicesOffsetsList = [
        // Horizontal runs
        [-4, -3, -2, -1, 0], [-3, -2, -1, 0, 1],
        [-2, -1, 0, 1, 2], [-1, 0, 1, 2, 3], [0, 1, 2, 3, 4],
        // Vertical runs
        [-60, -45, -30, -15, 0], [-45, -30, -15, 0, 15], [-30, -15, 0, 15, 30],
        [-15, 0, 15, 30, 45], [0, 15, 30, 45, 60],
        // Diagonal runs
        [-64, -48, -32, -16, 0], [-48, -32, -16, 0, 16], [-32, -16, 0, 16, 32],
        [-16, 0, 16, 32, 48], [0, 16, 32, 48, 64],
        [-56, -42, -28, -14, 0], [-42, -28, -14, 0, 14], [-28, -14, 0, 14, 28],
        [-14, 0, 14, 28, 42], [0, 14, 28, 42, 56]]
    
    var board: Board = Board()
    
    func doTurn() -> Bool {
        var gameOver = true
        
        if let whiteMoveIndex = doWhiteMove() {
            if !didWin(moveIndex: whiteMoveIndex) {
                if let blackMoveIndex = doBlackMove() {
                    gameOver = didWin(moveIndex: blackMoveIndex)
                }
            }
        }
        
        return gameOver
    }
    
    func doBlackMove() -> Int? {
        guard let moveIndex = board.availableMoves.randomElement() else {
            return nil
        }
        board = Board(board: board, index: moveIndex, square: .black)
        return moveIndex
    }

    func doWhiteMove() -> Int? {
        guard let moveIndex = board.availableMoves.randomElement() else {
            return nil
        }
        board = Board(board: board, index: moveIndex, square: .white)
        return moveIndex
    }
    
    func didWin(moveIndex: Int) -> Bool {
        assert(moveIndex < board.squares.count)
        let squareAtMove = board.squares[moveIndex]
        assert(squareAtMove != .outofbounds && squareAtMove != .empty)
        
        let runIndicesList = Game.runIndicesOffsetsList.map { (offsets: [Int]) -> [Int] in
            offsets.map { (offset: Int) -> Int in
                moveIndex + offset
            }
        }
        
        for runIndices in runIndicesList {
            let run = runIndices.map { (index) -> Square in
                board.squares[index]
            }
            
            if run.allSatisfy({ (square: Square) -> Bool in
                square == squareAtMove
            }) {
                print(runIndices)
                return true
            }
        }
        
        return false
    }
}
