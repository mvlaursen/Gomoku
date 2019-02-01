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
    struct BoardMetrics {
        let boardImageName: String
        let squareDim: CGFloat
        let blackImageName: String
        let whiteImageName: String
    }
    
    static func boardMetrics() -> BoardMetrics {
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
            
            let image = SKSpriteNode(imageNamed: metrics.boardImageName)
            board.addChild(image)
            
            let black = SKSpriteNode(imageNamed: metrics.blackImageName)
            black.position = CGPoint(x: metrics.squareDim, y: 0.0)
            board.addChild(black)
        
            let white = SKSpriteNode(imageNamed: metrics.whiteImageName)
            white.position = CGPoint(x: metrics.squareDim, y: metrics.squareDim)
            board.addChild(white)
            
            let black2 = SKSpriteNode(imageNamed: metrics.blackImageName)
            black2.position = CGPoint(x: 2.0 * metrics.squareDim, y: 0.0)
            board.addChild(black2)

            let white2 = SKSpriteNode(imageNamed: metrics.whiteImageName)
            white2.position = CGPoint(x: 2.0 * metrics.squareDim, y: metrics.squareDim)
            board.addChild(white2)
            
            self.presentScene(board)
        }
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
}
