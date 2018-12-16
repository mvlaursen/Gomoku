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
    var score: Int = 0
    
    init(board: Board) {
        self.board = board
        
        if let mostRecentMove = self.board.mostRecentMove {
            if mostRecentMove.mover == .black {
                score = Int.min
            } else if mostRecentMove.mover == .white {
                score = Int.max
            }
        }
    }
}
