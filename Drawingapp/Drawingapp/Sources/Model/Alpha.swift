//
//  Alpha.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

enum Alpha: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine, ten, max
    
    var description: String {
        "\(self.rawValue)"
    }
    
    var value: CGFloat  {
        CGFloat(self.rawValue) / CGFloat(Alpha.ten.rawValue)
    }
    
    var index: Int {
        self.rawValue
    }
}
