//
//  Game.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/29/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

protocol MoveChooser {
    // TODO: Have this return only the next moveIndex, not an entire node.
    func chooseNextMove(currentGameNode: GameNode) -> GameNode?
}

class Game {
    // In the Board class, the number of stones in a row for a win is
    // parameterized. But here we assume five in a row. It's fine for the
    // purposes of the app to assume five in a row because the intention is
    // only to support the traditional Gomoku game and there is no intention to
    // let the user customize the board size or winning conditions.
    private static let runIndicesOffsetsList = [
        // Horizontal runs
        [-4, -3, -2, -1, 0], [-3, -2, -1, 0, 1],
        [-2, -1, 0, 1, 2], [-1, 0, 1, 2, 3], [0, 1, 2, 3, 4],
        // Vertical runs
        [-92, -69, -46, -23, 0], [-69, -46, -23, 0, 23], [-46, -23, 0, 23, 46],
        [-23, 0, 23, 46, 69], [0, 23, 46, 69, 92],
        // Diagonal runs
        [-96, -72, -48, -24, 0], [-72, -48, -24, 0, 24], [-48, -24, 0, 24, 48],
        [-24, 0, 24, 48, 72], [0, 24, 48, 72, 96],
        [-88, -66, -44, -22, 0], [-66, -44, -22, 0, 22], [-44, -22, 0, 22, 44],
        [-22, 0, 22, 44, 66], [0, 22, 44, 66, 88]]
    
    private var mover = Player.black
    private(set) var rootNode: GameNode = GameNode(board: Board())
    private(set) var winningRun: Array<Int>? = nil
    
    private let blackMoveChooser: MoveChooser = BlackMoveChooser()
    private let whiteMoveChooser: MoveChooser = WhiteMoveChooser()

    func doTurn() -> Bool {
        if mover == Player.black {
            if let blackMoveIndex = doBlackMove() {
                if didWin(moveIndex: blackMoveIndex) {
                    return true
                }
                mover = Player.white
            }
        } else if mover == Player.white {
            if let whiteMoveIndex = doWhiteMove() {
                if didWin(moveIndex: whiteMoveIndex) {
                    return true
                }
                mover = Player.black
            }
        }
        
        return false
    }
    
    func doBlackMove() -> Int? {
        var moveIndex: Int? = nil
        
        // TO DO: Move this logic to BlackMoveChooser.
        if rootNode.board.mostRecentMove == nil {
            // The game always starts with black placing a stone in the center
            // of the board. There's a very small possibility that
            // mostRecentMove is nil because all squares have been filled but
            // there is no winner, so check that the first move is available.
            if rootNode.board.availableMoveIndices.contains(Board.centerIndex) {
                moveIndex = Board.centerIndex
            }
        } else {
            moveIndex = blackMoveChooser.chooseNextMove(currentGameNode: rootNode)?.board.mostRecentMove?.index
        }
        
        if moveIndex != nil {
            let board = Board(board: rootNode.board, index: moveIndex!)
            rootNode = GameNode(board: board)
        }
        
        return moveIndex
    }

    func doWhiteMove() -> Int? {
        guard let moveIndex = whiteMoveChooser.chooseNextMove(currentGameNode: rootNode)?.board.mostRecentMove?.index else {
            return nil
        }
        let board = Board(board: rootNode.board, index: moveIndex)
        rootNode = GameNode(board: board)
        return moveIndex
    }
    
    func didWin(moveIndex: Int) -> Bool {
        assert(moveIndex < rootNode.board.squares.count)
        let squareAtMove = rootNode.board.squares[moveIndex]
        assert(squareAtMove != .outofbounds && squareAtMove != .empty)
        
        let runIndicesList = generateRunIndicesList(moveIndex: moveIndex)
        
        for runIndices in runIndicesList {
            let run = runIndices.map { (index) -> Square in
                rootNode.board.squares[index]
            }
            
            if run.allSatisfy({ (square: Square) -> Bool in
                square == squareAtMove
            }) {
                print("\(squareAtMove): \(runIndices)")
                self.winningRun = runIndices
                return true
            }
        }
        
        return false
    }
    
    func generateRunIndicesList(moveIndex: Int) -> [[Int]] {
        assert(moveIndex < rootNode.board.squares.count)
        let squareAtMove = rootNode.board.squares[moveIndex]
        assert(squareAtMove != .outofbounds)

        let runIndicesList = Game.runIndicesOffsetsList.map { (offsets: [Int]) -> [Int] in
            offsets.map { (offset: Int) -> Int in
                moveIndex + offset
            }
        }
        
        return runIndicesList
    }
}
