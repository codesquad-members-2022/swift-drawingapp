//
//  Alpha.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/29.
//

import Foundation

// 투명도는 0~1사이인데 어디가 불투명인지 정해보아야한다!
enum Alpha: Int, CustomStringConvertible {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
}

