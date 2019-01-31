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
        let stoneDim: CGFloat
    }
    
    static func boardMetrics() -> BoardMetrics {
        let size = UIScreen.main.bounds.size
        let width = min(size.width, size.height)
        
        if width.isEqual(to: 375.0) {
            return BoardMetrics(boardImageName: "GomokuBoard368", squareDim: 23.0, stoneDim: 11.5)
        } else if width.isEqual(to: 768.0) {
            return BoardMetrics(boardImageName: "GomokuBoard768", squareDim: 48.0, stoneDim: 24.0)
        } else if width.isEqual(to: 414.0) {
            return BoardMetrics(boardImageName: "GomokuBoard400", squareDim: 25.0, stoneDim: 12.5)
        } else if width.isEqual(to: 1024.0) {
            return BoardMetrics(boardImageName: "GomokuBoard1024", squareDim: 64.0, stoneDim: 32.0)
        } else if width.isEqual(to: 834.0) {
            return BoardMetrics(boardImageName: "GomokuBoard768", squareDim: 48.0, stoneDim: 24.0)
        } else {
            return BoardMetrics(boardImageName: "GomokuBoard320", squareDim: 20.0, stoneDim: 10.0)
        }
    }
    
    override func layoutSubviews() {
        if self.scene == nil {
            let board = SKScene(size: self.bounds.size)
            board.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
            let metrics = BoardView.boardMetrics()
            let image = SKSpriteNode(imageNamed: metrics.boardImageName)
            board.addChild(image)
        
            self.presentScene(board)
        }
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
}
