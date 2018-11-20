//
//  GameNode.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class GameNode {    
    let board: Board
    
    var children: Array<GameNode> = []
    var heuristicScore: Int
    var minMaxScore = 0
    
    init(board: Board) {
        self.board = board
        
        if self.board.mostRecentMove.mover == .black {
            heuristicScore = Int.min
            minMaxScore = Int.min
        } else if self.board.mostRecentMove.mover == .white {
            heuristicScore = Int.max
            minMaxScore = Int.max
        } else {
            preconditionFailure()
        }
    }
}
