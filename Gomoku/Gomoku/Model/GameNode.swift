//
//  GameNode.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class GameNode {    
    typealias MoveChooser = (GameNode) -> Int?

    let board: Board
    
    var children: Array<GameNode> = []
    var heuristicScore: Int = 0
    var minMaxScore: Int = 0
    
    init(board: Board) {
        self.board = board
        
        if let mostRecentMove = self.board.mostRecentMove {
            if mostRecentMove.mover == .black {
                heuristicScore = Int.min
                minMaxScore = Int.min
            } else if mostRecentMove.mover == .white {
                heuristicScore = Int.max
                minMaxScore = Int.max
            }
        }
    }
}
