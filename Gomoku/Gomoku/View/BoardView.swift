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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let scene = SKScene(size: self.bounds.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let image = SKSpriteNode(imageNamed: "board.png")
        scene.addChild(image)
        
        self.presentScene(scene)
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
}
