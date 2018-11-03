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
        let squareDim = rect.size.width / CGFloat(Board.paddedBoardDim + 1)
        let lineStart = CGFloat(firstRank + 1) * squareDim
        let lineLength = CGFloat(firstRank + numRanks) * squareDim

        color.set()

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
    
    func drawStone(rect: CGRect, color: UIColor, row: Int, col: Int) {
        let squareDim = rect.size.width / CGFloat(Board.paddedBoardDim + 1)
        let stone = UIBezierPath()

        color.set()
        stone.addArc(withCenter: CGPoint(x: CGFloat(row) * squareDim, y: CGFloat(col) * squareDim), radius: squareDim / 3.0, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        stone.close()
        stone.fill()
        stone.stroke()
    }

    // Again, this is temporary silliness, just so we can see the board being
    // redrawn with each game turn.
    static let colors = [UIColor.black, UIColor.red, UIColor.green, UIColor.blue]
    
    override func draw(_ rect: CGRect) {
        // The rect is supposed to have a 1:1 aspect ratio layout constraint.
        assert(rect.size.width == rect.size.height)

        drawGrid(rect: rect, color: UIColor.lightGray, firstRank: 0, numRanks: Board.paddedBoardDim)
        drawGrid(rect: rect, color: BoardView.colors.randomElement()!, firstRank: 4, numRanks: Board.playableBoardDim)
        
        drawStone(rect: rect, color: UIColor.black, row: 5, col: 5)
        drawStone(rect: rect, color: UIColor.black, row: 6, col: 6)
        drawStone(rect: rect, color: UIColor.black, row: 7, col: 7)
        drawStone(rect: rect, color: UIColor.black, row: 8, col: 8)
        drawStone(rect: rect, color: UIColor.black, row: 9, col: 9)

    }
}
