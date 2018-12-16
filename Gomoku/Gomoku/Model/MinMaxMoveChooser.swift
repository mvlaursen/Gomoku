//
//  MinMaxMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 12/12/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

func minMaxMoveChooser(gameNode: GameNode) -> GameNode? {
    if let moveIndex = gameNode.board.availableMoveIndices.randomElement() {
        let nextBoard = Board(board: gameNode.board, index: moveIndex)
        return GameNode(board: nextBoard)
    } else {
        return nil
    }
}
