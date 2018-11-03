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
    
    func drawGrid(rect: CGRect, color: UIColor, firstRank: Int, numRanks: Int) {
        color.set()
        
        let squareDim = rect.size.width / CGFloat(Board.paddedBoardDim + 1)
        let lineStart = CGFloat(firstRank + 1) * squareDim
        let lineLength = CGFloat(firstRank + numRanks) * squareDim

        for rank in firstRank..<firstRank + numRanks {
            let lineOffset = CGFloat(rank + 1) * squareDim
            
            let horzLine = UIBezierPath()
            horzLine.move(to: CGPoint(x: lineStart, y: lineOffset))
            horzLine.addLine(to: CGPoint(x: lineLength, y: lineOffset))
            horzLine.close()
            horzLine.stroke()
            
            let vertLine = UIBezierPath()
            vertLine.move(to: CGPoint(x: lineOffset, y: lineStart))
            vertLine.addLine(to: CGPoint(x: lineOffset, y: lineLength))
            vertLine.close()
            vertLine.stroke()
        }
    }

    // Again, this is temporary silliness, just so we can see the board being
    // redrawn with each game turn.
    static let colors = [UIColor.black, UIColor.red, UIColor.green, UIColor.blue]
    
    override func draw(_ rect: CGRect) {
        // The rect is supposed to have a 1:1 aspect ratio layout constraint.
        assert(rect.size.width == rect.size.height)

        drawGrid(rect: rect, color: UIColor.lightGray, firstRank: 0, numRanks: Board.paddedBoardDim)
        drawGrid(rect: rect, color: BoardView.colors.randomElement()!, firstRank: 4, numRanks: Board.playableBoardDim)
    }
}
