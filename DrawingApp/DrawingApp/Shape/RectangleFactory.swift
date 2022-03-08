//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/03.
//

import Foundation

enum ShapeFactoryType {
    case rectangle(width: Double, height: Double)
    case square(length: Double)
    
    func make() -> Rectangle {
        switch self {
        case .rectangle(let width, let height):
            return RectangleFactory.make(size: Size(width: width, height: height))
        case .square(let length):
            return RectangleFactory.make(size: Size(width: length, height: length))
        }
    }
}


final class RectangleFactory {
    static func make(size: Size) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid, size: size)
    }
    
    static func make(in areaSize: Size) -> Rectangle {
        let r = RandomGenerator.make(min: 0, max: 255)
        let g = RandomGenerator.make(min: 0, max: 255)
        let b = RandomGenerator.make(min: 0, max: 255)
        let color = Color(red: r, green: g, blue: b)
        let size = Size(width: 150, height: 120)
        let randomPointX = RandomGenerator.make(min: 0, max: Int(areaSize.width - size.width))
        let randomPointY = RandomGenerator.make(min: 0, max: Int(areaSize.height - size.height))
        let point = Point(x: randomPointX, y: randomPointY)
        let alpha = RandomGenerator.make(min: 1, max: 10)
        let uid = UniqueID.generate()
        return Rectangle(uid: uid, point: point, size: size, color: color, alpha: alpha)
    }
}
