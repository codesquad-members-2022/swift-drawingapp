//
//  ViewPoint.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

struct ViewPoint: Hashable{
    let x: Int
    let y: Int
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}
extension ViewPoint: CustomStringConvertible{
    var description: String {
        return "X:\(x),Y:\(y)"
    }
}
