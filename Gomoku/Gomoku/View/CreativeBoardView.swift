//
//  CreativeBoardView.swift
//  Gomoku
//
//  Created by Mike Laursen on 2/3/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import UIKit

class CreativeBoardView: BoardView {
    private var blackOrWhite: Bool = true
    
    // MARK: Gesture Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var handledTouch = false
        
        if let touch = touches.first, let scene = self.scene {
            let location = touch.location(in: scene)
            let nodes = scene.nodes(at: location)
            let stones = nodes.filter { $0.isKind(of: BoardView.StoneNode.self) }
            // If our code is working correctly, there should never be more
            // than one stone in the same spot on the board.
            assert(stones.count <= 1)
            if stones.count > 0 {
                handledTouch = !stones.isEmpty
            } else {
                let boards = nodes.filter { $0.isKind(of: BoardView.BoardNode.self) }
                assert(boards.count <= 1)
                if boards.count > 0 {
                    if let board = boards.first {
                        if let moveIndex = moveIndex(for: touch.location(in: board)) {
                            let (row, column) = Board.rowAndColumnFrom(index: moveIndex)
                            let metrics = BoardView.boardMetrics()
                            let stoneImageName = blackOrWhite ? metrics.blackImageName : metrics.whiteImageName
                            let stone = StoneNode(imageNamed: stoneImageName)
                            stone.position = CGPoint(x: CGFloat(column) * metrics.squareDim, y: CGFloat(-row) * metrics.squareDim)
                            stone.zPosition = BoardView.kStoneZPosition
                            board.addChild(stone)
                            blackOrWhite = !blackOrWhite
                            
                            handledTouch = true
                        }
                    }
                }
            }
        }
        
        if !handledTouch {
            super.touchesBegan(touches, with: event)
        }
    }
}
