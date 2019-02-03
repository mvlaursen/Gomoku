//
//  IntExtensions.swift
//  Gomoku
//
//  Created by Mike Laursen on 2/2/19.
//  Copyright © 2019 Appamajigger. All rights reserved.
//

extension Int {
    func clamped(to limits: ClosedRange<Int>) -> Int {
        return Swift.min(Swift.max(self, limits.lowerBound), limits.upperBound)
    }
}
