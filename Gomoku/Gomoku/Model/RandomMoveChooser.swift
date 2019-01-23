//
//  RandomMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

// TODO: Move completely random testing to be used in testing only?
struct RandomMoveChooser: MoveChooser {
    func chooseNextMove(currentGameNode: GameNode) -> GameNode? {
        if let moveIndex = currentGameNode.board.availableMoveIndices.randomElement() {
            let nextBoard = Board(board: currentGameNode.board, index: moveIndex)
            return GameNode(board: nextBoard)
        } else {
            return nil
        }
    }
    
}
