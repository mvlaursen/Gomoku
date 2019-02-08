//
//  BoardView.swift
//  Gomoku
//
//  Created by Mike Laursen on 1/27/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

import SpriteKit
import UIKit

extension CGFloat {
    func matches(_ other: CGFloat, within tolerance: CGFloat) -> Bool {
        return abs(self - other) < tolerance
    }
}

class BoardView: SKView {
    static let kBoardZPosition = CGFloat(100.0)
    static let kStoneZPosition = CGFloat(200.0)
    static let kTapTolerance = CGFloat(2.5)
    
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
            let metrics = BoardView.boardMetrics()
            let scene = SKScene(size: self.bounds.size)
            
            // To make conversion from the location of a tap in the scene's
            // coordinate system to board row and column as straightforward as
            // possible, align row 0, column 0 of the board image with the
            // scene's origin. There is still the difference that the scene's
            // y-axis points up while row numbers increase from top to bottom
            // of the board, but aligning row 0 with y = 0 allows us to simply
            // negate the value of y when converting.
            
            let board = BoardNode(imageNamed: metrics.boardImageName)
            
            let squareDimInUnitSpace = 1.0 / CGFloat(GameConfiguration.squaresPerDim + 1)
            board.anchorPoint = CGPoint(x: squareDimInUnitSpace, y: 1.0 - squareDimInUnitSpace)
            
            // If our collection of artwork is done correctly, the board images
            // always fit within the available screen space.
            let xMargin = (scene.size.width - board.size.width) / 2.0
            let yMargin = (scene.size.height - board.size.height) / 2.0
            board.position = CGPoint(x: xMargin + metrics.squareDim, y: yMargin + CGFloat(GameConfiguration.squaresPerDim) * metrics.squareDim)
            board.zPosition = BoardView.kBoardZPosition
            
            scene.addChild(board)
            
            self.presentScene(scene)
        }
    }
    
    /**
     * - parameter for: Should be in the SKScene's coordinate system.
     */
    func moveIndex(for location: CGPoint) -> Int? {
        var retVal: Int? = nil
        
        print("moveIndex: location.x, .y: \(location.x), \(location.y)")
        
        let metrics = BoardView.boardMetrics()
        
        // Convert the location of the tap to a row and column on the board.
        //
        // However, only return the row and column if the tap is not ambiguous
        // (i.e. the tap is halfway between two rows or two columns, or the tap
        // is in the board's margin). To check for ambiguity, reverse engineer
        // the x and y coordinates of the tap from the row and column, then
        // test if the reverse-engineered x and y are close to the tap location
        // that was passed in.
        
        var column = Int(round(location.x / metrics.squareDim))
        column = column.clamped(to: BoardView.validSquares)
        let xFromColumn = CGFloat(column) * metrics.squareDim
        
        if xFromColumn.matches(location.x, within: metrics.squareDim / BoardView.kTapTolerance) {
            var row = Int(round(-location.y / metrics.squareDim))
            row = row.clamped(to: BoardView.validSquares)
            let yFromRow = CGFloat(-row) * metrics.squareDim
            
            if yFromRow.matches(location.y, within: metrics.squareDim / BoardView.kTapTolerance) {
                print("    x, y: \(xFromColumn), \(yFromRow)")
                print("    row, column: \(row), \(column)")
                retVal = Board.indexFromVisible(row: row, column: column)
            }
        }

        return retVal
    }
    
    func play(completion: @escaping () -> ()) {
        //completion()
    }
    
    func undo() {
    }
}
