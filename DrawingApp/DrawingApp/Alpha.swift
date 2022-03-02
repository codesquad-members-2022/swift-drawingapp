//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/02.
//

import Foundation


enum Alpha: Int, CustomStringConvertible, CaseIterable {
    case one = 1, two, three, four, five
    case six, seven, eight, nine, ten
    
    var description: String {
        return "Alpha: \(self.rawValue)"
    }
}
