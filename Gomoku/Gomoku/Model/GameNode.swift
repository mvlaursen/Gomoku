//
//  GameNode.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class GameNode {
    typealias Move = (mover: Square, index: Int)
    
    let board: Board
    let move: Move
    
    var children: Array<GameNode> = []
    var heuristicScore = 0
    var minMaxScore = 0
    
    init(board: Board, move: Move) {
        precondition(move.mover.isAPlayer)
        self.board = board
        self.move = move
    }
}
