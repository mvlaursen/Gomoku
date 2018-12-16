//
//  MinMaxMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 12/12/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

func evaluate(gameNode: GameNode) {
    if gameNode.children.count > 0 {
        for child in gameNode.children {
            evaluate(gameNode: child)
        }
        
        // TODO: Add pruning.
        if let mostRecentMove = gameNode.board.mostRecentMove {
            if mostRecentMove.mover == .black {
                gameNode.score = Int.min
                for child in gameNode.children {
                    gameNode.score = max(gameNode.score, child.score)
                }
            } else if mostRecentMove.mover == .white {
                gameNode.score = Int.max
                for child in gameNode.children {
                    gameNode.score = min(gameNode.score, child.score)
                }
            } // TODO: else?
        }
    } else {
        gameNode.score = gameNode.board.heuristicScore()
    }
}

func generateChildren(gameNode: GameNode, depth: Int) {
    if depth > 0 {
        if gameNode.children.count == 0 {
            // TODO: Come up with a better solution for limiting the number of
            // moves. The problem is that a tree based on ALL the available
            // moves is often too large to search in a reasonable time.
            let shuffledMoveIndices = gameNode.board.availableMoveIndices.shuffled()
            let cappedMoveIndices = shuffledMoveIndices.prefix(10)
            
            for moveIndex in cappedMoveIndices {
                let nextBoard = Board(board: gameNode.board, index: moveIndex)
                gameNode.children.append(GameNode(board: nextBoard))
            }
        }
        
        for child in gameNode.children {
            generateChildren(gameNode: child, depth: depth - 1)
        }
    }
}

func minMaxMoveChooser(gameNode: GameNode) -> GameNode? {
//    generateChildren(gameNode: gameNode, depth: 3)
//
//    if let mostRecentMove = gameNode.board.mostRecentMove {
//        if mostRecentMove.mover == .black {
//            var lowestScore = Int.max
//            var nodeTo
//
//            for child in gameNode.children {
//                evaluate(gameNode: child)
//            }
//        }
//    }
//
    
    return nil
}
