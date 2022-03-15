//
//  Alpha.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Alpha {
    var transparency : Double
    
    enum Range {
        static let min : Double = 0.1
        static let max : Double = 1
    }
    init (transparency : Double) {
        self.transparency = transparency
    }
}

extension Alpha : CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.transparency)"
    }
}
