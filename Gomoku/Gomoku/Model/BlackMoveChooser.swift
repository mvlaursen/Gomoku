//
//  BlackMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 1/23/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import Foundation

/**
 * BlackMoveChooser uses the classic min-max algorithm to choose moves, but
 * also has some logic specific to playing the black stones, such as special
 * handling of the first few moves in the game.
 */
struct BlackMoveChooser: MoveChooser {
    private let minMaxMoveChooser = MinMaxMoveChooser()
    
    func chooseNextMove(currentGameNode: GameNode) -> GameNode? {
        return minMaxMoveChooser.chooseNextMove(currentGameNode: currentGameNode)
    }
}
