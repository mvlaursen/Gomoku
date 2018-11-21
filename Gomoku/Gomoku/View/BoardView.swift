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

    private func drawGrid(rect: CGRect, color: UIColor, firstRank: Int, numRanks: Int) {
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
    
    private func highlightStone(rect: CGRect, row: Int, col: Int) {
        // TODO: We are calculating this same value in three different places.
        let squareDim = rect.size.width / CGFloat(Board.paddedBoardDim + 1)
        let highlight = UIBezierPath()
        
        UIColor.red.set()
        highlight.addArc(withCenter: CGPoint(x: CGFloat(col + 1) * squareDim, y: CGFloat(row + 1) * squareDim), radius: (squareDim / 3.0) + 1.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        highlight.close()
        highlight.stroke()
    }

    private func drawStone(rect: CGRect, color: UIColor, row: Int, col: Int) {
        let squareDim = rect.size.width / CGFloat(Board.paddedBoardDim + 1)
        let stone = UIBezierPath()

        color.set()
        stone.addArc(withCenter: CGPoint(x: CGFloat(col + 1) * squareDim, y: CGFloat(row + 1) * squareDim), radius: squareDim / 3.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        stone.close()
        stone.fill()
        stone.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // The rect is supposed to have a 1:1 aspect ratio layout constraint.
        assert(rect.size.width == rect.size.height)

        drawGrid(rect: rect, color: UIColor.lightGray, firstRank: 0, numRanks: Board.paddedBoardDim)
        drawGrid(rect: rect, color: UIColor.black, firstRank: Board.lowerBound, numRanks: GameConfiguration.boardDim)
        
        for row in Board.lowerBound..<GameConfiguration.boardDim + Board.lowerBound {
            for col in Board.lowerBound..<GameConfiguration.boardDim + Board.lowerBound {
                switch game.board.squares[row * Board.paddedBoardDim + col] {
                case .black: drawStone(rect: rect, color: UIColor.black, row: row, col: col)
                case .white: drawStone(rect: rect, color: UIColor.lightGray, row: row, col: col)
                default: break
                }
            }
        }
        
        if let winningRun = game.winningRun {
            for index in winningRun {
                let row = index / Board.paddedBoardDim
                let col = index - Board.paddedBoardDim * row
                highlightStone(rect: rect, row: row, col: col)
            }
        }
    }
}
