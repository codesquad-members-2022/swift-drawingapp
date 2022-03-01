//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//

final class RectangleFactory {
    
    private let id = RandomFactory.makeRandomID()
    private let origin = RandomFactory.makeRandomPoint()
    private let size = Size(width: 150, height: 120)
    private let alpha = RandomFactory.makeRandomAlpha()
    private let rgb = RandomFactory.makeRandomRGB()
    
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
