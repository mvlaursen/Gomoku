//
//  Board.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

struct Board {
    typealias Move = (mover: Square, index: Int)
    
    static let paddedSquaresPerDim = GameConfiguration.squaresPerDim + 2 * (GameConfiguration.winningRunLength - 1)
    private static let squaresCount: Int = Board.paddedSquaresPerDim * Board.paddedSquaresPerDim
    static let centerIndex: Int = Board.squaresCount / 2
    // The lower and upper bounds are included in the playable board area.
    static let lowerBound = GameConfiguration.winningRunLength - 1
    static let upperBound = lowerBound + GameConfiguration.squaresPerDim - 1
    
    let availableMoveIndices: Set<Int>
    let mostRecentMove: Move?
    // Even though a Gomoku board is two-dimensional, modeling the board as a
    // one-dimensional array makes some things easier, such as keeping a list
    // of moves that are still available, using higher order array functions to
    // check for winning runs, etc.
    let squares: [Square]
    
    static func indexFrom(row: Int, column: Int) -> Int {
        // TODO: Get rid of this precondition by defining a range?
        precondition(row >= 0 && row < Board.paddedSquaresPerDim)
        precondition(column >= 0 && column < Board.paddedSquaresPerDim)
        
        return row * Board.paddedSquaresPerDim + column
    }
    
    static func rowAndColumnFrom(index: Int) -> (row: Int, column: Int) {
        precondition(index >= 0 && index < Board.squaresCount)
        let row = index / Board.paddedSquaresPerDim
        let column = index % Board.paddedSquaresPerDim
        return (row: row, column: column)
    }

    init() {
        var mutableAvailableMoveIndices = Set<Int>()
        var mutableSquares = Array<Square>(repeating: .outofbounds,
            count: Board.squaresCount)
        
        for row in Board.lowerBound...Board.upperBound {
            for column in Board.lowerBound...Board.upperBound {
                    let index = Board.indexFrom(row: row, column: column)
                    mutableAvailableMoveIndices.insert(row * Board.paddedSquaresPerDim + column)
                    mutableSquares[index] = .empty
            }
        }
        
        self.availableMoveIndices = mutableAvailableMoveIndices
        self.mostRecentMove = nil
        self.squares = mutableSquares
    }
    
    init(board other: Board, index: Int) {
        precondition(index > 0 && index < other.squares.count)
        
        var mover = Square.black
        if let mostRecentMove = other.mostRecentMove {
            mover = mostRecentMove.mover == Square.black ? Square.white : Square.black
        }
        self.mostRecentMove = (mover: mover, index: index)
        
        var newAvailableMoves = other.availableMoveIndices
        newAvailableMoves.remove(index)
        self.availableMoveIndices = newAvailableMoves
        
        var newSquares = other.squares
        newSquares[index] = mover
        self.squares = newSquares
    }

    func heuristicScore() -> Int {
        var score = 0
        
        for row in Board.lowerBound..<Board.upperBound {
            for column in Board.lowerBound..<Board.upperBound {
                let index = Board.indexFrom(row: row, column: column)
                let runIndicesList = adjacentIndicesOffsetsList.map { (offsets: [Int]) -> [Int] in
                    offsets.map { (offset: Int) -> Int in
                        index + offset
                    }
                }
                for runIndices in runIndicesList {
                    let run = runIndices.map { (index) -> Square in
                        self.squares[index]
                    }
                    if run.allSatisfy({ (square) -> Bool in
                        square == .black
                    }) {
                        score = score + 1
                    }
                    else if run.allSatisfy({ (square) -> Bool in
                        square == .white
                    }) {
                        score = score - 1
                    }
                }
            }
        }
        
        return score
    }
    
    func heuristicScoreQuick() -> Int {
        var score = 0
        
        let centerIndex = self.mostRecentMove?.index ?? Board.centerIndex
        let center = Board.rowAndColumnFrom(index: centerIndex)
        
        for row in (center.row - 2)..<(center.row + 2) {
            for column in (center.column - 2)..<(center.column + 2) {
                let index = Board.indexFrom(row: row, column: column)
                let runIndicesList = adjacentIndicesOffsetsList.map { (offsets: [Int]) -> [Int] in
                    offsets.map { (offset: Int) -> Int in
                        index + offset
                    }
                }
                for runIndices in runIndicesList {
                    let run = runIndices.map { (index) -> Square in
                        self.squares[index]
                    }
                    if run.allSatisfy({ (square) -> Bool in
                        square == .black
                    }) {
                        score = score + 1
                    }
                    else if run.allSatisfy({ (square) -> Bool in
                        square == .white
                    }) {
                        score = score - 1
                    }
                }
            }
        }
        
        return score
    }
}

