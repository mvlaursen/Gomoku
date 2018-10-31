//
//  Game.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/29/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class Game {
    var board: Board = Board()
    
    func doTurn() -> Bool {
        var gameOver = true
        
        if let whiteMoveIndex = doWhiteMove() {
            if !didWin(moveIndex: whiteMoveIndex) {
                if let blackMoveIndex = doBlackMove() {
                    gameOver = didWin(moveIndex: blackMoveIndex)
                }
            }
        }
        
        return gameOver
    }
    
    func doBlackMove() -> Int? {
        guard let moveIndex = board.availableMoves.randomElement() else {
            return nil
        }
        board = Board(board: board, index: moveIndex, square: .black)
        return moveIndex
    }

    func doWhiteMove() -> Int? {
        guard let moveIndex = board.availableMoves.randomElement() else {
            return nil
        }
        board = Board(board: board, index: moveIndex, square: .white)
        return moveIndex
    }
    
    func didWin(moveIndex: Int) -> Bool {
        assert(moveIndex < board.squares.count)
        let squareAtMove = board.squares[moveIndex]
        assert(squareAtMove != .empty)
        
        let list = generateListOfRunIndices(moveIndex: moveIndex)
        
        for runIndices in list {
            let run = runIndices.map { (index) -> Square in
                board.squares[index]
            }
            let reduction = run.reduce(true) { (result, square) -> Bool in
                if result {
                    return square == squareAtMove
                } else {
                    return result
                }
            }
            if reduction {
                print(runIndices)
                return true
            }
        }
        
        return false
    }
    
    // Templates for run indices
    static let horzTemplates = [[-4, -3, -2, -1, 0], [-3, -2, -1, 0, 1],
        [-2, -1, 0, 1, 2], [-1, 0, 1, 2, 3], [0, 1, 2, 3, 4]]
    static let vertTemplates = [[-60, -45, -30, -15, 0],
        [-45, -30, -15, 0, 15], [-30, -15, 0, 15, 30], [-15, 0, 15, 30, 45],
        [0, 15, 30, 45, 60]]
    static let diagTemplates = [[-64, -48, -32, -16, 0],
        [-48, -32, -16, 0, 16], [-32, -16, 0, 16, 32], [-16, 0, 16, 32, 48],
        [0, 16, 32, 48, 64]]
    static let rdiagTemplates = [[-56, -42, -28, -14, 0],
        [-42, -28, -14, 0, 14], [-28, -14, 0, 14, 28], [-14, 0, 14, 28, 42],
        [0, 14, 28, 42, 56]]
    
    func offsetTemplates(templates: [[Int]], offset: Int) -> [[Int]] {
        let runIndices = templates.map { (template: [Int]) -> [Int] in
            template.map { (index: Int) -> Int in
                index + offset
            }
        }
        return runIndices
    }
    
    func filterByRunBounds(runIndicesList: [[Int]], lowerBound: Int, upperBound: Int) -> [[Int]] {
        let filteredRunIndicesList = runIndicesList.filter { (runIndices: [Int]) -> Bool in
            runIndices.allSatisfy({ (index) -> Bool in
                index >= lowerBound && index <= upperBound
            })
        }
        return filteredRunIndicesList
    }

    // TODO: This is a complicated calculation. Consider replacing all of this
    // with a pre-generated run list for each move index.
    func generateListOfRunIndices(moveIndex: Int) -> [[Int]] {
        var runIndicesList: [[Int]] = []
        
        // Horizontal run indices
        
        let horzIndices = offsetTemplates(templates: Game.horzTemplates, offset: moveIndex)
        let leftmostInRow = 15 * (moveIndex / 15)
        let rightmostInRow = leftmostInRow + 14
        let horzIndicesFiltered = filterByRunBounds(runIndicesList: horzIndices, lowerBound: leftmostInRow, upperBound: rightmostInRow)
        runIndicesList.append(contentsOf: horzIndicesFiltered)
        
        // Vertical run indices
        
        let vertIndices = offsetTemplates(templates: Game.vertTemplates, offset: moveIndex)
        let topInCol = max(0, moveIndex - 60)
        let bottomInCol = min(224, moveIndex + 60)
        let vertIndicesFiltered = filterByRunBounds(runIndicesList: vertIndices, lowerBound: topInCol, upperBound: bottomInCol)
        runIndicesList.append(contentsOf: vertIndicesFiltered)
        
        let diagIndices = offsetTemplates(templates: Game.diagTemplates, offset: moveIndex)
        let topLeftCorner = max(0, moveIndex - 64)
        let bottomRightCorner = min(224, moveIndex + 64)
        let diagIndicesFiltered = filterByRunBounds(runIndicesList: diagIndices, lowerBound: topLeftCorner, upperBound: bottomRightCorner)
        runIndicesList.append(contentsOf: diagIndicesFiltered)
        
        let rdiagIndices = offsetTemplates(templates: Game.rdiagTemplates, offset: moveIndex)
        let topRightCorner = max(0, moveIndex - 56)
        let bottomLeftCorner = min(224, moveIndex + 56)
        let rdiagIndicesFiltered = filterByRunBounds(runIndicesList: rdiagIndices, lowerBound: topRightCorner, upperBound: bottomLeftCorner)
        runIndicesList.append(contentsOf: rdiagIndicesFiltered)
        
       return runIndicesList
    }
}
