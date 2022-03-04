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
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
    
    func xValue() -> Int{
        return x
    }
    
    func yValue() -> Int{
        return y
    }
}
extension ViewPoint: CustomStringConvertible{
    var description: String {
        return "X:\(x),Y:\(y)"
    }
}
