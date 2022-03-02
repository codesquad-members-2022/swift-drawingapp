//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/03.
//

import Foundation


final class RectangleFactory {
    static func make(colorType: Color.Standard, x: Double = 0, y: Double, width: Double = 100, height: Double = 100) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid, point: Rectangle.Point(x: x, y: y), size: Rectangle.Size(width: width, height: height), color: colorType.rgb, alpha: 1)
    }
    
    static func make(x: Double, y: Double, width: Double, height: Double) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid, point: Rectangle.Point(x: x, y: y), size: Rectangle.Size(width: width, height: height), color: Color.Standard.white.rgb, alpha: 1)
    }
    
    static func make(origin: Rectangle.Point, size: Rectangle.Size) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid, point: origin, size: size, color: Color.Standard.white.rgb, alpha: 1)
    }
}
