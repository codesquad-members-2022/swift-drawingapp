//
//  Alpha.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Alpha {
    var transparency : Double
    
    static let alphaRange = 0.1...1
    init? (transparency : Double) {
        guard Alpha.alphaRange.contains(transparency) else {return nil}
        self.transparency = transparency
    }
}

extension Alpha : CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.transparency)"
    }
}
