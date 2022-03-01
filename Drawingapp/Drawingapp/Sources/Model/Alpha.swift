//
//  Alpha.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

enum Alpha: Int, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine, ten
    
    var description: String {
        "\(self.rawValue)"
    }
    
    var value: CGFloat  {
        CGFloat(self.rawValue) / CGFloat(Alpha.ten.rawValue)
    }
}
