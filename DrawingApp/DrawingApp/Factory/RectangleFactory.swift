//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//


//Image가 들어가있는 Rectangle, 기본 plane Rectangle들을 Rectangle로 묶어서 Factory메서드를 사용할수 있을것 같아 선언했습니다.
final class RectangleFactory:RectangleCreator {
    
    func makeRectangle(type:Rectangle.Type) -> Rectangle {
        let id = IDFactory.makeRandomID()
        let size = Size(width: 150, height: 120)
        let origin = Point.random()
        let rgb = RGB.random()
        let alpha = Alpha.random()
        
        //PlaneRectangle은 가장 기본이 되는 Rectangle로 생각하여 default값으로 두고 type을 처리했습니다.
        switch ObjectIdentifier(type) {
        case ObjectIdentifier(ImageRectangle.self):
            return ImageRectangle(id: id, origin: origin, size: size, rgb: rgb, alpha: alpha)
        default:
            return PlaneRectangle(id: id, origin: origin, size: size, rgb: rgb, alpha: alpha)
        }
    }
}
