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
    var R: Int
    var G: Int
    var B: Int
    var A: Int

    init(_ id: String, _ size: Size, _ point: Point, _ r: Int, _ g: Int, _ b: Int, _ a: Int) {
        self.id = id
        self.size = size
        self.point = point
        self.R = r
        self.G = g
        self.B = b
        self.A = a
    }
    
    var description: String {
        return "(\(id)), X:\(point.X),Y:\(point.Y), W\(size.Width), H\(size.Height), R:\(R), G:\(G), B:\(B), Alpha: \(A)"
    }
}
