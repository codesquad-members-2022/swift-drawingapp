//
//  Alpha.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/08.
//

import Foundation

enum Alpha: Int {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
}

extension Alpha: CustomStringConvertible {
    var description: String {
        return "Alpha:\(self.rawValue)"
    }
}
