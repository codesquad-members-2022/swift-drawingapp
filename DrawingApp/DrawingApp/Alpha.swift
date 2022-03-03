//
//  Alpha.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/03.
//

import Foundation

enum Alpha: Int, CustomStringConvertible, CaseIterable{
    
    case one = 1, two, three, four, five, six, seven, eight, nine, ten
    
    var description: String {
        return "Alpha : \(self.rawValue)"
    }
}
