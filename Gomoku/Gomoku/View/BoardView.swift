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
            image.name = "Foo"
            image.size.width = CGFloat(320)
            image.size.height = CGFloat(320)
            board.addChild(image)
        
            self.presentScene(board)
        }
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
    
    func setImageSize(dim: CGFloat) {
        let image = scene?.childNode(withName: "Foo") as! SKSpriteNode
        let resize = SKAction.resize(toWidth: dim, height: dim, duration: 0.2)
        image.run(resize)
    }
}
