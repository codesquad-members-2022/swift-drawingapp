//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

enum Alpha: Int {
    case one = 1, two, three, four, five
    case six, seven, eight, nine, ten
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
}
