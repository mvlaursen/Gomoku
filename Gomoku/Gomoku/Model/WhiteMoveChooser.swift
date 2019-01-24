//
//  WhiteMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 1/23/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import Foundation

/**
 * WhiteMoveChooser uses the classic min-max algorithm to choose moves, but
 * also has some logic specific to playing the white stones, such as special
 * handling of the first few moves in the game.
 */
struct WhiteMoveChooser: MoveChooser {
    private let minMaxMoveChooser = MinMaxMoveChooser()
    
    func chooseNextMove(currentGameNode: GameNode) -> GameNode? {
        precondition(currentGameNode.board.mostRecentMove?.mover == Player.black)
        
        if currentGameNode.board.mostRecentMove?.index == Board.centerIndex {
            if currentGameNode.board.availableMoveIndices.contains(Board.centerIndex + 1) {
                return GameNode(board: Board(board: currentGameNode.board, index: Board.centerIndex + 1))
            }
        } else {
            return minMaxMoveChooser.chooseNextMove(currentGameNode: currentGameNode)
        }
        
        return nil
    }
}
