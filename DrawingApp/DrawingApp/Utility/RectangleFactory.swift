//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/04.
//

import Foundation

protocol ShapeBuilder {
    static func makeShape() -> Shapable
}

enum RectangleFactory: ShapeBuilder {
    static func makeRectangle(x: Double = 0, y: Double = 0, width: Double = 30, height: Double = 30) -> Shapable {
        let id = IdentifierFactory.makeTypeRandomly()
        return ColoredRectangle(id: id, x: x, y: y, width: width, height: height, color: .white, alpha: .opaque)
    }
    
    static func makeRandomRectangle() -> Shapable {
        let id = IdentifierFactory.makeTypeRandomly()
        let point = PointFactory.makeTypeRandomly()
        let size = SizeFactory.makeType(width: 150, height: 120)
        let color = ColorFactory.makeTypeRandomly()
        let alpha = Alpha.randomElement()
        
        return ColoredRectangle(id: id, origin: point, size: size, color: color, alpha: alpha)
    }
    
    static func makeRandomRectangle(with image: URL) -> Shapable {
        let id = IdentifierFactory.makeTypeRandomly()
        let point = PointFactory.makeTypeRandomly()
        let size = SizeFactory.makeType(width: 150, height: 120)
        
        return ImageRectangle(id: id, origin: point, size: size, image: image)
    }
    
    static func makeShape() -> Shapable {
        return self.makeRectangle()
    }
}
