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
}
