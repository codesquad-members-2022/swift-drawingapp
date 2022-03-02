//
//  Alpha.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
//값이 낮을수록 투명함.
enum Alpha : Int , CustomStringConvertible , CaseIterable{
    case One = 1
    case Two
    case Three
    case Four
    case Five
    case Six
    case Seven
    case Eight
    case Nine
    case Ten
    var description: String {
        "Alpha : \(self.rawValue)"
    }
}
