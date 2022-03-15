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

    init(_ id: String, _ size: Size, _ point: Point, _ r: Int, _ g: Int, _ b: Int, _ a: Int) {
        self.id = id
        self.size = size
        self.point = point

        self.R = setRGBDegree(r)
        self.G = setRGBDegree(g)
        self.B = setRGBDegree(b)
        switch a {
        case ...0 :
            self.A = 0
        case 10...:
            self.A = 10
        default:
            self.A = a
        }
    }
    
    func setRGBDegree(_ deg: Int) -> Int {
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
