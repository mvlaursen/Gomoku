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
    
    func nearestSquare(location: CGPoint) -> (x: Int, y: Int) {
        let metrics = BoardView.boardMetrics()
        let x = Int((7.0 * metrics.squareDim + location.x) / metrics.squareDim)
        let yInverted = -1.0 * location.y
        print("location: \(location.x), \(yInverted)")
        let y = Int((7.0 * metrics.squareDim + yInverted) / metrics.squareDim)
        print("    square at: \(x), \(y)")
        return (x, y)
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
                        let square = nearestSquare(location: touch.location(in: board))
                        print(square)
                        handledTouch = true
                    }
                }
            }
        }
        
        if !handledTouch {
            super.touchesBegan(touches, with: event)
        }
    }
}
