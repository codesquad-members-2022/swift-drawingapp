//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

class BackgroundColor {
    let R: Int
    let G: Int
    let B: Int
    
    init(R: Int, G: Int, B: Int) {
        self.R = R
        self.G = G
        self.B = B
    }
}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "(R: \(R), G: \(G), B: \(B))"
    }
}
