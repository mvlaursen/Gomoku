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

func regenerateChildren(gameNode: GameNode, depth: Int) {
    if depth > 0 {
        gameNode.children = Array<GameNode>()
        
        let shuffledMoveIndices = gameNode.board.availableMoveIndices.shuffled()
        var highestScore = Int.min
            
        for moveIndex in shuffledMoveIndices {
            let childBoard = Board(board: gameNode.board, index: moveIndex)
            let childNode = GameNode(board: childBoard)
            childNode.score = childNode.board.heuristicScoreQuick()
            highestScore = max(highestScore, childNode.score)
            if childNode.score >= highestScore {
                gameNode.children.append(childNode)
            }
        }
        
        gameNode.children = gameNode.children.filter { (childNode) -> Bool in
            childNode.score == highestScore
        }
        
        for child in gameNode.children {
            regenerateChildren(gameNode: child, depth: depth - 1)
        }
    }
}

func minMaxMoveChooser(gameNode: GameNode) -> GameNode? {
    let depth = 9 - Int(log2(Float(gameNode.board.availableMoveIndices.count)))
    print("==> available: \(gameNode.board.availableMoveIndices.count) depth: \(depth)")
    return minMaxMoveChooserAux(gameNode: gameNode, depth: depth);
}

func minMaxMoveChooserAux(gameNode: GameNode, depth: Int) -> GameNode? {
    var nextMove:GameNode? = nil

    regenerateChildren(gameNode: gameNode, depth: depth)

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
