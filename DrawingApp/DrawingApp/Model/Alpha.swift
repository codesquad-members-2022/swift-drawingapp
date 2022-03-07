//
//  Alpha.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Alpha {
    var transparency : Double
    
    static let alphaRange = 1...10
    init? (transparency : Int) {
        guard Alpha.alphaRange.contains(transparency) else {return nil}
        self.transparency = Double(transparency)/10
    }
}

extension Alpha : CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.transparency)"
    }
}
