//
//  CreativeBoardView.swift
//  Gomoku
//
//  Created by Mike Laursen on 2/3/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import UIKit

/**
 * I added CreativeBoardView at my daughter's request.
 *
 * She enjoys simply placing black and white stones in patterns on the board,
 * perhaps more than she enjoys playing Gomoku. So, there is an optional app
 * mode in Settings that lets the user do exactly that. Note that this view
 * doesn't even interact with the game model.
 */
class CreativeBoardView: BoardView {
    private static let kTimeInterval = 0.1

    private var previousBoard: Board? = nil
    private var board = Board()
    
    override func play(completion: @escaping () -> ()) {        
        Timer.scheduledTimer(withTimeInterval: CreativeBoardView.kTimeInterval, repeats: true) { timer in
            self.updateBoard()
            if self.board.availableMoveIndices.isEmpty {
                timer.invalidate()
                self.updateBoard()
                completion()
            }
        }
    }
    
    override func quit() {
        previousBoard = nil
        board = Board()
    }
    
    override func undo() {
        if let previous = previousBoard {
            board = previous;
            previousBoard = nil
        }
    }
    
    private func updateBoard() {
        if let scene = self.scene {
            let boardNodes = scene.children.filter { $0.isKind(of: BoardNode.self) }
            assert(boardNodes.count <= 1)
            if boardNodes.count > 0 {
                if let boardNode = boardNodes.first {
                    boardNode.removeAllChildren()
                    
                    for row in 0..<GameConfiguration.squaresPerDim {
                        for column in 0..<GameConfiguration.squaresPerDim {
                            let square = board.squares[Board.indexFromVisible(row: row, column: column)]
                            if square == .black || square == .white {
                                let metrics = BoardView.boardMetrics()
                                let stoneImageName = square == .black ? metrics.blackImageName : metrics.whiteImageName
                                let stone = StoneNode(imageNamed: stoneImageName)
                                stone.position = CGPoint(x: CGFloat(column) * metrics.squareDim, y: CGFloat(-row) * metrics.squareDim)
                                stone.zPosition = BoardView.kStoneZPosition
                                boardNode.addChild(stone)
                            }
                        }
                    }
                }
            }
        }
        

    }

    // MARK: Gesture Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let scene = self.scene {
            let location = touch.location(in: scene)
            let nodes = scene.nodes(at: location)
            let stones = nodes.filter { $0.isKind(of: BoardView.StoneNode.self) }
            // If our code is working correctly, there should never be more
            // than one stone in the same spot on the board.
            assert(stones.count <= 1)
            
            if stones.isEmpty {
                let boardNodes = nodes.filter { $0.isKind(of: BoardView.BoardNode.self) }
                assert(boardNodes.count <= 1)
                if boardNodes.count > 0 {
                    if let boardNode = boardNodes.first {
                        if let moveIndex = moveIndex(for: touch.location(in: boardNode)) {
                            previousBoard = board
                            board = Board(board: board, index: moveIndex)
                        }
                    }
                }
            }
        }
    }
}
