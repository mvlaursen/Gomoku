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
    let kBoardZPosition = CGFloat(100.0)
    let kStoneZPosition = CGFloat(200.0)
    
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
            board.zPosition = kBoardZPosition
        
            let metrics = BoardView.boardMetrics()
            
            let image = BoardNode(imageNamed: metrics.boardImageName)
            board.addChild(image)
            
            self.presentScene(board)
        }
    }
    
    func moveIndex(for location: CGPoint) -> Int? {
        var retVal: Int? = nil
        
        let metrics = BoardView.boardMetrics()
        
        // TODO: Should define these constants based on GameConfiguration.squaresPerDim
        
        let column = Int(round(location.x / metrics.squareDim) + 7.0).clamped(to: 0...14)
        let xFromColumn = CGFloat(column - 7) * metrics.squareDim //CGFloat(7 - row) * metrics.squareDim
        let xDiff = abs(location.x - xFromColumn)
        
        if xDiff < metrics.squareDim / 2.5 {
            let row = Int(round(7.0 - location.y / metrics.squareDim)).clamped(to: 0...14)
            let yFromRow = CGFloat(7 - row) * metrics.squareDim
            let yDiff = abs(location.y - yFromRow)

            if yDiff < metrics.squareDim / 2.5 {
                retVal = Board.indexFrom(row: row, column: column)
            }
        }

        return retVal
    }
    
    func play(completion: @escaping () -> ()) {
        completion()
    }
}
