//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

import Foundation

//Image가 들어가있는 Rectangle, 기본 plane Rectangle들을 Rectangle로 묶어서 Factory메서드를 사용할수 있을것 같아 선언
final class RectangleFactory {
    
    static func makePlaneRectangle() -> PlaneRectangle {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let origin = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha.random()
        
        return PlaneRectangle(id: id, origin: origin, size: size, rgb: rgb, alpha: alpha)
    }
    
    static func makeImageRectangle(imageData:Data) -> ImageRectangle {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let origin = Point.random()
        let alpha = Alpha(1)
        let imageData = imageData
        
        return ImageRectangle(id: id, origin: origin, size: size, alpha: alpha, imageData: imageData)
    }
    
    
}
