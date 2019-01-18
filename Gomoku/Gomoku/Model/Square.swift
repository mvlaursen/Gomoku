//
//  Square.swift
//  Gomoku
//
//  Created by Mike Laursen on 11/20/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

enum Square {
    case outofbounds
    case empty
    case black
    case white
    
    public var isAPlayer: Bool {
        get {
            return self == .black || self == .white
        }
    }
}
