//
//  Alpha.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

enum Alpha: Int, CustomStringConvertible {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
    
    var description: String {
        "\(self.rawValue)"
    }
}
