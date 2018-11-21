//
//  HeuristicScoreMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

// TODO: Provide a way to choose the best move for .black or .white.

// TODO: Instead of calculating the heuristic score from scratch each time, can
// we make an incremental adjustment to the heuristic score from the starting
// board?

let adjacentIndicesOffsetsList = [
    // Horizontal adjacency
    [0, 1],
    // Vertical adjacency
    [0, 23],
    // Diagonal adjacency
    [0, 24], [0, 22]]

func heuristicScoreMoveChooser(board: Board) -> Int? {
    var maximize = true
    if board.mostRecentMove != nil && board.mostRecentMove!.mover == Square.black {
        maximize = false
    }
    
    var bestMoveIndex: Int? = nil
    var bestScore = maximize ? Int.min : Int.max
    
    for moveIndex in board.availableMoveIndices.shuffled() {
        let nextBoard = Board(board: board, index: moveIndex)
        let score = heuristicScore(board: nextBoard)

        if maximize && score > bestScore {
            bestMoveIndex = moveIndex
            bestScore = score
        } else if !maximize && score < bestScore {
            bestMoveIndex = moveIndex
            bestScore = score
        }
    }
    
    return bestMoveIndex
}

func heuristicScore(board: Board) -> Int {
    var score = 0
    
    for row in Board.lowerBound..<Board.upperBound {
        for column in Board.lowerBound..<Board.upperBound {
            let index = Board.indexFrom(row: row, column: column)
            let runIndicesList = adjacentIndicesOffsetsList.map { (offsets: [Int]) -> [Int] in
                offsets.map { (offset: Int) -> Int in
                    index + offset
                }
            }
            for runIndices in runIndicesList {
                let run = runIndices.map { (index) -> Square in
                    board.squares[index]
                }
                if run.allSatisfy({ (square) -> Bool in
                    square == .black
                }) {
                    score = score + 1
                }
                else if run.allSatisfy({ (square) -> Bool in
                    square == .white
                }) {
                    score = score - 1
                }
            }
        }
    }
        
    return score
}


