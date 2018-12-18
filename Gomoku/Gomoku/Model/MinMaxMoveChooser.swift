//
//  MinMaxMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 12/12/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

func assignMinMaxScore(gameNode: GameNode) {
    if gameNode.children.count > 0 {
        for child in gameNode.children {
            assignMinMaxScore(gameNode: child)
        }
        
        // TODO: Add pruning.
        if let mostRecentMove = gameNode.board.mostRecentMove {
            if mostRecentMove.mover == .black {
                gameNode.score = Int.max
                for child in gameNode.children {
                    gameNode.score = min(gameNode.score, child.score)
                }
            } else if mostRecentMove.mover == .white {
                gameNode.score = Int.min
                for child in gameNode.children {
                    gameNode.score = max(gameNode.score, child.score)
                }
            } // TODO: else?
        }
    } else {
        gameNode.score = gameNode.board.heuristicScore()
    }
}

func generateChildren(gameNode: GameNode, depth: Int, maxMovesPerLevel: Int) {
    if depth > 0 {
        if gameNode.children.count == 0 {
            // TODO: Come up with a better solution for limiting the number of
            // moves. The problem is that a tree based on ALL the available
            // moves is often too large to search in a reasonable time.
            //
            // Perhaps instead of choosing moves randomly, write a
            // heuristicScore() function for moves and use that to pick moves.
            let shuffledMoveIndices = gameNode.board.availableMoveIndices.shuffled()
            let cappedMoveIndices = shuffledMoveIndices.prefix(maxMovesPerLevel)
            
            for moveIndex in cappedMoveIndices {
                let nextBoard = Board(board: gameNode.board, index: moveIndex)
                gameNode.children.append(GameNode(board: nextBoard))
            }
        }
        
        for child in gameNode.children {
            generateChildren(gameNode: child, depth: depth - 1, maxMovesPerLevel: maxMovesPerLevel)
        }
    }
}

func minMaxMoveChooser(gameNode: GameNode) -> GameNode? {
    return minMaxMoveChooserAux(gameNode: gameNode, depth: 3, maxMovesPerLevel: 5)
}

func minMaxMoveChooserAux(gameNode: GameNode, depth: Int, maxMovesPerLevel: Int) -> GameNode? {
    var nextMove:GameNode? = nil

    generateChildren(gameNode: gameNode, depth: depth, maxMovesPerLevel: maxMovesPerLevel)

    if let mostRecentMove = gameNode.board.mostRecentMove {
        // TODO: Make this work for either the black or white player. Right now
        // it only works for black.

        if mostRecentMove.mover == .white {
            gameNode.score = Int.min

            for child in gameNode.children {
                assignMinMaxScore(gameNode: child)
                if child.score > gameNode.score {
                    gameNode.score = child.score
                    nextMove = child
                }
            }
        }
    }
    
    return nextMove
}
