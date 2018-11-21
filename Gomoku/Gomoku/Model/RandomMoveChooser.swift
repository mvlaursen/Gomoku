//
//  RandomMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

// TODO: Move completely random testing to be used in testing only?
func randomMoveChooser(gameNode: GameNode) -> GameNode? {
    if let moveIndex = gameNode.board.availableMoveIndices.randomElement() {
        let nextBoard = Board(board: gameNode.board, index: moveIndex)
        return GameNode(board: nextBoard)
    } else {
        return nil
    }
}
