//
//  Utils.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation
extension Double {
    var trim : Double {
        let formatter = NumberFormatter()
        formatter.roundingMode = .floor
        formatter.maximumFractionDigits = 4
        let str = formatter.string(from: NSNumber(value: self))
        return Double(str!)!
    }
}
