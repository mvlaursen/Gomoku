//
//  BoardView.swift
//  Gomoku
//
//  Created by Mike Laursen on 1/27/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import SpriteKit
import UIKit

class BoardView: SKView {
    private struct BoardMetrics {
        let boardImageName: String
        let squareDim: CGFloat
        let blackImageName: String
        let whiteImageName: String
    }
    
    private class BoardNode: SKSpriteNode {
    }
    
    private class StoneNode: SKSpriteNode {
    }
    
    private static func boardMetrics() -> BoardMetrics {
        let size = UIScreen.main.bounds.size
        let width = min(size.width, size.height)
        
        if width.isEqual(to: 375.0) {
            return BoardMetrics(boardImageName: "GomokuBoard368", squareDim: 23.0, blackImageName: "BlackStone21", whiteImageName: "WhiteStone21")
        } else if width.isEqual(to: 768.0) {
            return BoardMetrics(boardImageName: "GomokuBoard768", squareDim: 48.0, blackImageName: "BlackStone45", whiteImageName: "WhiteStone45")
        } else if width.isEqual(to: 414.0) {
            return BoardMetrics(boardImageName: "GomokuBoard400", squareDim: 25.0, blackImageName: "BlackStone23", whiteImageName: "WhiteStone23")
        } else if width.isEqual(to: 1024.0) {
            return BoardMetrics(boardImageName: "GomokuBoard1024", squareDim: 64.0, blackImageName: "BlackStone60", whiteImageName: "WhiteStone60")
        } else if width.isEqual(to: 834.0) {
            return BoardMetrics(boardImageName: "GomokuBoard768", squareDim: 48.0, blackImageName: "BlackStone45", whiteImageName: "WhiteStone45")
        } else {
            return BoardMetrics(boardImageName: "GomokuBoard320", squareDim: 20.0, blackImageName: "BlackStone18", whiteImageName: "WhiteStone18")
        }
    }
    
    override func layoutSubviews() {
        if self.scene == nil {
            let board = SKScene(size: self.bounds.size)
            board.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
            let metrics = BoardView.boardMetrics()
            
            let image = BoardNode(imageNamed: metrics.boardImageName)
            board.addChild(image)
            
            let black = StoneNode(imageNamed: metrics.blackImageName)
            black.position = CGPoint(x: metrics.squareDim, y: 0.0)
            board.addChild(black)
        
            let white = StoneNode(imageNamed: metrics.whiteImageName)
            white.position = CGPoint(x: metrics.squareDim, y: metrics.squareDim)
            board.addChild(white)
            
            let black2 = StoneNode(imageNamed: metrics.blackImageName)
            black2.position = CGPoint(x: 2.0 * metrics.squareDim, y: 0.0)
            board.addChild(black2)

            let white2 = StoneNode(imageNamed: metrics.whiteImageName)
            white2.position = CGPoint(x: 2.0 * metrics.squareDim, y: metrics.squareDim)
            board.addChild(white2)
            
            self.presentScene(board)
        }
    }
    
    private func moveIndex(for location: CGPoint) -> Int? {
        var retVal: Int? = nil
        
        let metrics = BoardView.boardMetrics()
        
        // TODO: Should define these constants based on GameConfiguration.squaresPerDim
        
        let column = Int(round(location.x / metrics.squareDim) + 7.0).clamped(to: 0...14)
        let xFromColumn = CGFloat(column - 7) * metrics.squareDim //CGFloat(7 - row) * metrics.squareDim
        let xDiff = abs(location.x - xFromColumn)
        
        if xDiff < metrics.squareDim / 2.5 {
            let row = Int(round(7.0 - location.y / metrics.squareDim)).clamped(to: 0...14)
            let yFromRow = CGFloat(7 - row) * metrics.squareDim
            let yDiff = abs(location.y - yFromRow)

            if yDiff < metrics.squareDim / 2.5 {
                retVal = Board.indexFrom(row: row, column: column)
            }
        }

        return retVal
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
    
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
                            print("moveIndex: \(moveIndex)")
                            print("    row: \(row), column: \(column)")
                        
                            let metrics = BoardView.boardMetrics()
                            let black = StoneNode(imageNamed: metrics.blackImageName)
                            black.position = CGPoint(x: CGFloat(column - 7) * metrics.squareDim, y: CGFloat(7 - row) * metrics.squareDim)
                            board.addChild(black)

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
