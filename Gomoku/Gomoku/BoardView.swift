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
    
    override func draw(_ rect: CGRect) {
        // The rect is supposed to have a 1:1 aspect ratio layout constraint.
        assert(rect.size.width == rect.size.height)

        let numSquaresPadded = CGFloat(Board.paddedBoardDim)
        let numSquaresPlayable = CGFloat(Board.playableBoardDim)
        let squareDim = rect.size.width / (numSquaresPadded + 1.0)

        UIColor.lightGray.set()
        for row in 1...Board.paddedBoardDim {
            let rank = CGFloat(row) * squareDim
            let lineLength = numSquaresPadded * squareDim
            let horzLine = UIBezierPath()
            horzLine.move(to: CGPoint(x: squareDim, y: rank))
            horzLine.addLine(to: CGPoint(x: lineLength, y: rank))
            horzLine.close()
            horzLine.stroke()
            
            let vertLine = UIBezierPath()
            vertLine.move(to: CGPoint(x: rank, y: squareDim))
            vertLine.addLine(to: CGPoint(x: rank, y: lineLength))
            vertLine.close()
            vertLine.stroke()
        }
        
        UIColor.black.set()
        for row in 5...(Board.playableBoardDim + 4) {
            let rank = CGFloat(row) * squareDim
            let lineLength = numSquaresPlayable * squareDim
            let horzLine = UIBezierPath()
            horzLine.move(to: CGPoint(x: 5.0 * squareDim, y: rank))
            horzLine.addLine(to: CGPoint(x: 4.0 * squareDim + lineLength, y: rank))
            horzLine.close()
            horzLine.stroke()
            
            let vertLine = UIBezierPath()
            vertLine.move(to: CGPoint(x: rank, y: 5.0 * squareDim))
            vertLine.addLine(to: CGPoint(x: rank, y: 4.0 * squareDim + lineLength))
            vertLine.close()
            vertLine.stroke()
        }
    }
}
