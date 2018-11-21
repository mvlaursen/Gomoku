//
//  Game.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/29/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class Game {
    // In the Board class, the number of stones in a row for a win is
    // parameterized. But here we assume five in a row. It's fine for the
    // purposes of the app to assume five in a row because the intention is
    // only to support the traditional Gomoku game and there is no intention to
    // let the user customize the board size or winning conditions.
    static let runIndicesOffsetsList = [
        // Horizontal runs
        [-4, -3, -2, -1, 0], [-3, -2, -1, 0, 1],
        [-2, -1, 0, 1, 2], [-1, 0, 1, 2, 3], [0, 1, 2, 3, 4],
        // Vertical runs
        [-92, -69, -46, -23, 0], [-69, -46, -23, 0, 23], [-46, -23, 0, 23, 46],
        [-23, 0, 23, 46, 69], [0, 23, 46, 69, 92],
        // Diagonal runs
        [-96, -72, -48, -24, 0], [-72, -48, -24, 0, 24], [-48, -24, 0, 24, 48],
        [-24, 0, 24, 48, 72], [0, 24, 48, 72, 96],
        [-88, -66, -44, -22, 0], [-66, -44, -22, 0, 22], [-44, -22, 0, 22, 44],
        [-22, 0, 22, 44, 66], [0, 22, 44, 66, 88]]
    
    var board: Board = Board()
    var firstMove: Bool = true
    var winningRun: Array<Int>? = nil
    
    let blackMoveChooser: Board.MoveChooser = randomMoveChooser
    let whiteMoveChooser: Board.MoveChooser = randomMoveChooser
    
    func doTurn() -> Bool {
        if let blackMoveIndex = doBlackMove() {
            if didWin(moveIndex: blackMoveIndex) {
                return true
            } else if let whiteMoveIndex = doWhiteMove() {
                if didWin(moveIndex: whiteMoveIndex) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func doBlackMove() -> Int? {
        var moveIndex: Int? = nil
        
        // The game always starts with black placing a stone in the center of
        // the board.
        if firstMove {
            firstMove = false
            moveIndex = board.squares.count / 2
        } else {
            moveIndex = blackMoveChooser(board)
        }
        
        if moveIndex != nil {
            board = Board(board: board, index: moveIndex!)
        }
        
        return moveIndex
    }

    func doWhiteMove() -> Int? {
        guard let moveIndex = heuristicScoreMoveChooser(board: board) else {
            return nil
        }
        board = Board(board: board, index: moveIndex)
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
                print("\(squareAtMove): \(runIndices)")
                self.winningRun = runIndices
                return true
            }
        }
        
        return false
    }
}
