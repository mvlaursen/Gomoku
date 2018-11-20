//
//  HeuristicScoreMoveChooser.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

let adjacentIndicesOffsetsList = [
    // Horizontal runs
    [0, 1, 2, 3, 4],
    // Vertical runs
    [0, 23, 46, 69, 92],
    // Diagonal runs
    [0, 24, 48, 72, 96], [0, 22, 44, 66, 88]]

func heuristicScoreMoveChooser(board: Board) -> Int? {
    return board.availableMoveIndices.randomElement()
}

fileprivate func score(board: Board) -> Int {
    let score = 0
    
    for row in Board.lowerBound...Board.upperBound {
        for column in Board.lowerBound...Board.upperBound {
            let index = Board.indexFrom(row: row, column: column)
        }
    }
        
    return score
}


