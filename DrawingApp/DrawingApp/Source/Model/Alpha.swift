//
//  Alpha.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/29.
//

import Foundation

// 투명도는 0~1사이인데 어디가 불투명인지 정해보아야한다!
enum Alpha: Double, CaseIterable {
    case one = 0.1
    case two = 0.2
    case three = 0.3
    case four = 0.4
    case five = 0.5
    case six = 0.6
    case seven = 0.7
    case eight = 0.8
    case nine = 0.9
    case ten = 1.0
    
    static var random: Alpha {
        var randomAlpha = Alpha.allCases.shuffled()
        return randomAlpha.removeFirst()
    }
    
}

