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
    static let kBoardZPosition = CGFloat(100.0)
    static let kStoneZPosition = CGFloat(200.0)
    static let kTapTolerance = CGFloat(2.5)
    
    static let centerSquare = GameConfiguration.squaresPerDim / 2
    private static let validSquares = (0...(GameConfiguration.squaresPerDim - 1))
    
    struct BoardMetrics {
        let boardImageName: String
        let squareDim: CGFloat
        let blackImageName: String
        let whiteImageName: String
    }
    
    class BoardNode: SKSpriteNode {
    }
    
    class StoneNode: SKSpriteNode {
    }
    
    static func boardMetrics() -> BoardMetrics {
        let size = UIScreen.main.bounds.size
        let width = min(size.width, size.height)
        
        if width.isEqual(to: 375.0) {
            return BoardMetrics(boardImageName: "GomokuBoard368", squareDim: 23.0, blackImageName: "BlackStone21", whiteImageName: "WhiteStone21")
        } else if width.isEqual(to: 768.0) {
            return BoardMetrics(boardImageName: "GomokuBoard768", squareDim: 48.0, blackImageName: "BlackStone45", whiteImageName: "WhiteStone45")
        } else if width.isEqual(to: 414.0) {
            return BoardMetrics(boardImageName: "GomokuBoard400", squareDim: 25.0, blackImageName: "BlackStone23", whiteImageName: "WhiteStone23")
        } else if width.isEqual(to: 1024.0) {
            return BoardMetrics(boardImageName: "GomokuBoard1024", squareDim: 64.0, blackImageName: "BlackStone60", whiteImageName: "WhiteStone60")
        } else if width.isEqual(to: 834.0) {
            return BoardMetrics(boardImageName: "GomokuBoard768", squareDim: 48.0, blackImageName: "BlackStone45", whiteImageName: "WhiteStone45")
        } else {
            return BoardMetrics(boardImageName: "GomokuBoard320", squareDim: 20.0, blackImageName: "BlackStone18", whiteImageName: "WhiteStone18")
        }
    }
    
    override func layoutSubviews() {
        if self.scene == nil {
            let board = SKScene(size: self.bounds.size)
            board.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            board.zPosition = BoardView.kBoardZPosition
        
            let metrics = BoardView.boardMetrics()
            
            let image = BoardNode(imageNamed: metrics.boardImageName)
            board.addChild(image)
            
            self.presentScene(board)
        }
    }
    
    func moveIndex(for location: CGPoint) -> Int? {
        var retVal: Int? = nil
        
        let metrics = BoardView.boardMetrics()
        
        let column = (Int(round(location.x / metrics.squareDim)) + BoardView.centerSquare).clamped(to: BoardView.validSquares)
        let xFromColumn = CGFloat(column - BoardView.centerSquare) * metrics.squareDim
        let xDiff = abs(location.x - xFromColumn)
        
        if xDiff < metrics.squareDim / BoardView.kTapTolerance {
            let row = (BoardView.centerSquare - Int(round(location.y / metrics.squareDim))).clamped(to: BoardView.validSquares)
            let yFromRow = CGFloat(BoardView.centerSquare - row) * metrics.squareDim
            let yDiff = abs(location.y - yFromRow)

            if yDiff < metrics.squareDim / BoardView.kTapTolerance {
                retVal = Board.indexFrom(row: row, column: column)
            }
        }

        return retVal
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
}
