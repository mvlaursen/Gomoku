//
//  HeuristicScoreMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import Foundation

// TODO: Instead of calculating the heuristic score from scratch each time, can
// we make an incremental adjustment to the heuristic score from the starting
// board?
struct HeuristicScoreMoveChooser: MoveChooser {
    func chooseNextMove(currentGameNode: GameNode) -> GameNode? {
        var maximize = true
        if currentGameNode.board.mostRecentMove != nil && currentGameNode.board.mostRecentMove!.mover == Player.black {
            maximize = false
        }
        
        var bestNextBoard: Board? = nil
        var bestScore = maximize ? Int.min : Int.max
        
        for moveIndex in currentGameNode.board.availableMoveIndices.shuffled() {
            let nextBoard = Board(board: currentGameNode.board, index: moveIndex)
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
}
