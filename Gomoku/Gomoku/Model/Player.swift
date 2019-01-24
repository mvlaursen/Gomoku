//
//  Player.swift
//  Gomoku
//
//  Created by Mike Laursen on 1/23/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import Foundation

enum Player {
    case black
    case white
    
    // Convenient for figuring out which player has the current move if you
    // know which player made the most recent move.
    func nextPlayer() -> Player {
        switch self {
        case Player.black:
            return Player.white
        case Player.white:
            return Player.black
        }
    }
    
    func toSquare() -> Square {
        switch self {
        case Player.black:
            return Square.black
        case Player.white:
            return Square.white
        }
    }
}
