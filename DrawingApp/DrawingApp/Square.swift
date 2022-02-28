//
//  SquareViewInfo.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation

class Square{
    private var uniqueId: String
    private var color: SquareColor
    private var point: ViewPoint
    
    init(uniqueId: String, color: SquareColor, point: ViewPoint){
        self.uniqueId = uniqueId
        self.color = color
        self.point = point
    }
}

extension Square: CustomStringConvertible{
    var description: String {
        return "(\(uniqueId)) \(point.description) \(color.description)"
    }
}
