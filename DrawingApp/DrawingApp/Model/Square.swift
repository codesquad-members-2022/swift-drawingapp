//
//  Square.swift
//  DrawingApp
//
//  Created by 허태양 on 2022/03/10.
//

import Foundation

class Square : CustomStringConvertible {
    var id: String
    var size: Size
    var point: Point
    var R: Int = 0
    var G: Int = 0
    var B: Int = 0
    var A: Int = 0

    init(id: String, size: Size, point: Point, r: Int, g: Int, b: Int, a: Int) {
        self.id = id
        self.size = size
        self.point = point

        self.R = setRGBDegree(deg: r)
        self.G = setRGBDegree(deg: g)
        self.B = setRGBDegree(deg: b)
        switch a {
        case ...0 :
            self.A = 0
        case 10...:
            self.A = 10
        default:
            self.A = a
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
    
    var description: String {
        return "(\(id)), X:\(point.X),Y:\(point.Y), W\(size.Width), H\(size.Height), R:\(R), G:\(G), B:\(B), Alpha: \(A)"
    }
}
