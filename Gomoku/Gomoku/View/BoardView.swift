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
    
    func play(completion: @escaping () -> ()) {
        game = Game()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let gameOver = self.game.doTurn()
            self.setNeedsDisplay()
            if gameOver {
                timer.invalidate()
                completion()
            }
        }
    }

    // MARK: Drawing

    private func drawGrid(squareDim: CGFloat, color: UIColor, firstRank: Int, numRanks: Int) {
        let lineStart = squareDim
        let lineLength = CGFloat(numRanks) * squareDim

        color.set()

        for rank in 0..<numRanks {
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
    
    private func highlightStone(squareDim: CGFloat, row: Int, col: Int) {
        let highlight = UIBezierPath()
        UIColor.red.set()
        highlight.addArc(withCenter: CGPoint(x: CGFloat(col - Board.lowerBound + 1) * squareDim, y: CGFloat(row - Board.lowerBound + 1) * squareDim), radius: (squareDim / 3.0) + 1.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        highlight.close()
        highlight.stroke()
    }

    private func drawStone(squareDim: CGFloat, color: UIColor, row: Int, col: Int) {
        let stone = UIBezierPath()
        color.set()
        stone.addArc(withCenter: CGPoint(x: CGFloat(col - Board.lowerBound + 1) * squareDim, y: CGFloat(row - Board.lowerBound + 1) * squareDim), radius: squareDim / 3.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        stone.close()
        stone.fill()
        stone.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // The rect is supposed to have a 1:1 aspect ratio layout constraint.
        assert(rect.size.width == rect.size.height)
        
        let squareDim = rect.size.width / CGFloat(GameConfiguration.squaresPerDim + 1)

        drawGrid(squareDim: squareDim, color: UIColor.black, firstRank: Board.lowerBound, numRanks: GameConfiguration.squaresPerDim)
        
        for row in Board.lowerBound..<Board.lowerBound + GameConfiguration.squaresPerDim {
            for col in Board.lowerBound..<Board.lowerBound + GameConfiguration.squaresPerDim {
                switch game.rootNode.board.squares[Board.indexFrom(row: row, column: col)] {
                case .black: drawStone(squareDim: squareDim, color: UIColor.black, row: row, col: col)
                case .white: drawStone(squareDim: squareDim, color: UIColor.lightGray, row: row, col: col)
                default: break
                }
            }
        }
        
        if let winningRun = game.winningRun {
            for index in winningRun {
                let (row, col) = Board.rowAndColumnFrom(index: index)
                highlightStone(squareDim: squareDim, row: row, col: col)
            }
        }
    }
}
