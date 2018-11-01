//
//  BoardView.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/1/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import UIKit

class BoardView: UIView {
    var game = Game()

/*    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.render(board: game.board)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let gameOver = self.game.doTurn()
//            self.render(board: self.game.board)
            if gameOver {
                timer.invalidate()
            }
        }
    }*/
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        self.render(board: game.board)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let gameOver = self.game.doTurn()
            //            self.render(board: self.game.board)
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

}
