//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

final class RectangleFactory {
    
    static func makeRectangleAtRandomPoint(id:String,origin:Point,size:Size, backGroundColor:RGB, alpha:Alpha) -> Rectangle {
        let rectangleAtRandomPoint = Rectangle (
            id: id,
            origin:origin,
            size: size,
            backGroundColor: backGroundColor,
            alpha: alpha
        )
        return rectangleAtRandomPoint
    }
}
