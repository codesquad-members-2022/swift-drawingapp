//
//  Square.swift
//  DrawingApp
//
//  Created by 허태양 on 2022/03/10.
//

import Foundation

class Square : CustomStringConvertible {
    private var id: String
    private var size: Size
    private var point: Point
    private var R: Int = 0
    private var G: Int = 0
    private var B: Int = 0
    private var A: Int = 0

    init(id: String, size: Size, point: Point, r: Int, g: Int, b: Int, alpha: Int) {
        self.id = id
        self.size = size
        self.point = point

        self.R = setRGBDegree(deg: r)
        self.G = setRGBDegree(deg: g)
        self.B = setRGBDegree(deg: b)
        switch alpha {
        case ...0 :
            self.A = 0
        case 10...:
            self.A = 10
        default:
            self.A = alpha
        }
    }
    
    func setRGBDegree(deg: Int) -> Int {
        switch deg {
        case ...0 :
            return 0
        case 256...:
            return 256
        default:
            return deg
        }
    }
    
    func isPointIncluded(position: Point) -> Bool {
        let X1: Double = self.point.X
        let X2: Double = self.point.X + self.size.Width
        let Y1: Double = self.point.Y
        let Y2: Double = self.point.Y + self.size.Height
        if (X1 <= position.X && position.X <= X2) && (Y1 <= position.Y && position.Y <= Y2) {
            return true
        }
        return false
    }
    
    var description: String {
        return "(\(id)), X:\(point.X),Y:\(point.Y), W\(size.Width), H\(size.Height), R:\(R), G:\(G), B:\(B), Alpha: \(A)"
    }
}
