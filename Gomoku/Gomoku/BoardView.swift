//
//  BoardView.swift
//  Gomoku
//
//  Created by Mike Laursen on 10/28/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import UIKit

// This text-based view is temporary and will be replaced with a graphic,
// SpriteKit-based view.
class BoardView: UITextView {
    var game = Game()
    
    // Temporary, just to test board rendering.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.render(board: game.board)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let gameOver = self.game.doTurn()
            self.render(board: self.game.board)
            if gameOver {
                timer.invalidate()
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func render(board: Board) {
        var text = ""
        
        for i in 0..<Board.paddedBoardDim {
            for j in 0..<Board.paddedBoardDim {
                switch board.squares[i * Board.paddedBoardDim + j] {
                case .outofbounds:
                    text.append("-")
                case .empty:
                    text.append(".")
                case .black:
                    text.append("B")
                case .white:
                    text.append("W")
                }
            }
            text.append("\n")
        }
        
        self.text = text
    }
}
