//
//  main.swift
//  BigNerdRanch-4
//
//  Created by jeongminho on 2020/06/01.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

// Ch14 예선과제, 본선과제
enum ShapeDimensions {
    case square(side: Double)
    case rectangle(width: Double, height: Double)
    case rightTriangle(side: Double, height: Double)
    
    func perimeter() -> Double {
        switch self {
        case let .square(side: side):
            return 4 * side
        case let .rectangle(width: width, height: height):
            return 2*width + 2*height
        case let .rightTriangle(side: side, height: height):
            return 0
        }
    }
    
    func area() -> Double {
        switch self {
        case let .rectangle(width: w, height: h):
            return 2*w + 2*h
        case let .square(side: s):
            return 4*s
        case let .rightTriangle(side: s, height: h):
            return s * h / 2
        }
    }
}
