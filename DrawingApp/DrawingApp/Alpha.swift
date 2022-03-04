//
//  Alpha.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Alpha {
    private var transparency : Int
    
    static let alphaRange = 0...10
    init? (transparency : Int) {
        guard Alpha.alphaRange.contains(transparency) else {return nil}
        self.transparency = transparency
    }
}

extension Alpha : CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.transparency)"
    }
}
