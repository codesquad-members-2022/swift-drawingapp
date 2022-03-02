//
//  Alpha.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
enum Alpha : Int , CustomStringConvertible{
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
