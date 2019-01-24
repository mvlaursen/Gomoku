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
    
    func toSquare() -> Square {
        switch self {
        case Player.black:
            return Square.black
        case Player.white:
            return Square.white
        }
    }
}
