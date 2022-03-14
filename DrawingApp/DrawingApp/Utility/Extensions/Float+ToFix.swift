//
//  Float+ToFix.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/14.
//

import Foundation

extension Float {
    func toFixed(digits: Int) -> Self {
        let divisor = pow(10, Self.init(digits))
        return (self * divisor).rounded() / divisor
    }
}
