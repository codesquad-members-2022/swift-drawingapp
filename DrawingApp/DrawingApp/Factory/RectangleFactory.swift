//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

final class RectangleFactory {
    
    let id = RandomFactory.makeRandomID()
    let origin = RandomFactory.makeRandomPoint()
    let size = Size(width: 150, height: 120)
    let alpha = RandomFactory.makeRandomAlpha()
    let rgb = RandomFactory.makeRandomRGB()
    
    func makeRectangleAtRandomPoint() -> Rectangle {
        let rectangleAtRandomPoint = Rectangle (
            id: id,
            origin:origin,
            size: size,
            backGroundColor: rgb,
            alpha: alpha
        )
        return rectangleAtRandomPoint
    }
}
