//
//  Alpha.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class Alpha {
    private var transparency : Int
    
    init(transparency : Int) {
        switch transparency {
        case ...0 :
            self.transparency = 0
        case 10... :
            self.transparency = 10
        default:
            self.transparency = transparency
        }
    }
}

extension Alpha : CustomStringConvertible {
    var description: String {
        return "Alpha: \(self.transparency)"
    }
}
