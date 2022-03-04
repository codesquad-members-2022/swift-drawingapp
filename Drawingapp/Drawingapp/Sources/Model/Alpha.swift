//
//  Alpha.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

enum Alpha: Int, CaseIterable, CustomStringConvertible {
    case transpar0, transpar1, transpar2, transpar3, transpar4
    case transpar5, transpar6, transpar7, transpar8, transpar9, transpar10
    
    var description: String {
        "\(self.rawValue)"
    }
    
    var value: CGFloat  {
        CGFloat(self.rawValue) / CGFloat(Alpha.max.rawValue)
    }
    
    var index: Int {
        self.rawValue
    }
    
    static var max: Alpha {
        .transpar10
    }
}
