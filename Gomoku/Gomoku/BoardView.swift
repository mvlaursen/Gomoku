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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let gameOver = self.game.doTurn()
            self.setNeedsDisplay()
            if gameOver {
                timer.invalidate()
            }
        }
    }
    
    let colors = [UIColor.red, UIColor.green, UIColor.blue]

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        assert(rect.size.width == rect.size.height)

        let numSquares = CGFloat(Board.paddedBoardDim)
        let squareDim = rect.size.width / (numSquares + 1.0)

        // This is hinky, but it's just temporary: change the color each time
        // we draw just so we can see that we are redrawing.
        colors.randomElement()!.set()
        
        for row in 1...Board.paddedBoardDim {
            let y = CGFloat(row) * squareDim
            let horzLine = UIBezierPath()
            horzLine.move(to: CGPoint(x: squareDim, y: y))
            horzLine.addLine(to: CGPoint(x: numSquares * squareDim, y: y))
            horzLine.close()
            horzLine.stroke()
            
            let vertLine = UIBezierPath()
            vertLine.move(to: CGPoint(x: y, y: squareDim))
            vertLine.addLine(to: CGPoint(x: y, y: numSquares * squareDim))
            vertLine.close()
            vertLine.stroke()
        }
    }
}
