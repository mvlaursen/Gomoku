//
//  HeuristicScoreMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

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

func heuristicScoreMoveChooser(gameNode: GameNode) -> GameNode? {
    var maximize = true
    if gameNode.board.mostRecentMove != nil && gameNode.board.mostRecentMove!.mover == Square.black {
        maximize = false
    }
    
    var bestNextBoard: Board? = nil
    var bestScore = maximize ? Int.min : Int.max
    
    for moveIndex in gameNode.board.availableMoveIndices.shuffled() {
        let nextBoard = Board(board: gameNode.board, index: moveIndex)
        let score = nextBoard.heuristicScore()

        if maximize && score > bestScore {
            bestNextBoard = nextBoard
            bestScore = score
        } else if !maximize && score < bestScore {
            bestNextBoard = nextBoard
            bestScore = score
        }
    }
    
    if let bestNextBoard = bestNextBoard {
        return GameNode(board: bestNextBoard)
    } else {
        return nil
    }
}


