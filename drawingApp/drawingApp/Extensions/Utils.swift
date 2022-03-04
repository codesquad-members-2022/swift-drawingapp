//
//  Utils.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation
import UIKit

extension Double {
    var trim : Double {
        let str = String(format: "%.1f", self)
        return Double(str)!
    }
}

extension CGFloat {
    var trim : Double {
        let str = String(format: "%.1f", self)
        return Double(str)!
    }
}
