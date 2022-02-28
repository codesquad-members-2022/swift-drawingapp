//
//  ViewPoint.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct ViewPoint{
    private var x: Int
    private var y: Int
    private var height: Int
    private var width: Int
    init(x: Int, y: Int, width: Int, height: Int){
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}
extension ViewPoint: CustomStringConvertible{
    var description: String {
        return "X:\(x),Y:\(y), W\(width), H\(height)"
    }
}
