//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

final class RectangleFactory:RectangleCreator {
    
    func makePlaneRectangle() -> PlaneRectangle {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha.random()
        
        let rect = PlaneRectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
        
        return rect
    }
    
    func makeImageRectangle() -> ImageRectangle {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let point = Point.random()
        let alpha = Alpha.random()
        
        let rect = ImageRectangle(id: id, origin: point, size: size, alpha: alpha)
        return rect
    }
}
