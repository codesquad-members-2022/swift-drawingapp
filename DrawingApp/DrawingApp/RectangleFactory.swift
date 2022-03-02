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
            return RectangleFactory.make(size: Rectangle.Size(width: width, height: height))
        case .square(let length):
            return RectangleFactory.make(size: Rectangle.Size(width: length, height: length))
        }
    }
}


final class RectangleFactory {
    static func make(colorType: Color.Standard, x: Double = 0, y: Double, width: Double = 100, height: Double = 100) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid,
                         point: Rectangle.Point(x: x, y: y),
                         size: Rectangle.Size(width: width, height: height),
                         color: colorType.rgb,
                         alpha: 1)
    }
    
    static func make(x: Double, y: Double, width: Double, height: Double) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid,
                         point: Rectangle.Point(x: x, y: y),
                         size: Rectangle.Size(width: width, height: height),
                         color: Color.Standard.white.rgb, alpha: 1)
    }
    
    static func make(x: Int, y: Int, width: Int, height: Int) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid,
                         point: Rectangle.Point(x: Double(x), y: Double(y)),
                         size: Rectangle.Size(width: Double(width), height: Double(height)),
                         color: Color.Standard.white.rgb,
                         alpha: 1)
    }
    
    static func make(origin: Rectangle.Point = .init(x: 0, y: 0), size: Rectangle.Size) -> Rectangle {
        let uid = UniqueID.generate()
        return Rectangle(uid: uid,
                         point: origin,
                         size: size,
                         color: Color.Standard.white.rgb,
                         alpha: 1)
    }
}
