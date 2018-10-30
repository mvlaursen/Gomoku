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
        assert(squareAtMove != .empty)
        
        let list = generateListOfRunIndices(moveIndex: moveIndex)
        
        for runIndices in list {
            let run = runIndices.map { (index) -> Square in
                board.squares[index]
            }
            let reduction = run.reduce(true) { (result, square) -> Bool in
                if result {
                    return square == squareAtMove
                } else {
                    return result
                }
            }
            if reduction {
                print(runIndices)
                return true
            }
        }
        
        return false
    }
    
    func generateListOfRunIndices(moveIndex: Int) -> [[Int]] {
        // TODO This only generates horizontal runs within a single row. Need
        // to generate diagonal and vertical runs.
        
        let leftIndexForRow = 15 * (moveIndex / 15)
        let leftIndex = max(moveIndex - 4, leftIndexForRow)
        let rightIndex = min(moveIndex, leftIndexForRow + 10)
        var list: [[Int]] = []

        for index in leftIndex...rightIndex {
            list.append([index, index + 1, index + 2, index + 3, index + 4])
        }
        
        return list
    }
}
