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
    override func layoutSubviews() {
        if self.scene == nil {
            let board = SKScene(size: self.bounds.size)
            board.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
            let image = SKSpriteNode(imageNamed: "board.png")
            board.addChild(image)
        
            self.presentScene(board)
        }
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
}
