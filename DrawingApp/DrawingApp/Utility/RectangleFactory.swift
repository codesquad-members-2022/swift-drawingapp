//
//  RectangleFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/04.
//

import Foundation

enum RectangleFactory: ShapeBuildable {
    static func makeShape(ofClass type: Shapable.Type) -> Shapable? {
        switch type {
        case is ColoredRectangle.Type:
            return self.makeColoredRectangle()
        case is ImageRectangle.Type:
            return self.makeImageRectangle()
        default:
            return nil
        }
    }
    
    static func makeColoredRectangle(x: Double = 0, y: Double = 0, width: Double = 150, height: Double = 120) -> ColoredRectangle {
        let id = IdentifierFactory.makeTypeRandomly()
        return ColoredRectangle(id: id, x: x, y: y, width: width, height: height, color: .white, alpha: .opaque)
    }
    
    static func makeImageRectangle(x: Double = 0, y: Double = 0, width: Double = 150, height: Double = 120, url: URL? = nil) -> ImageRectangle {
        let id = IdentifierFactory.makeTypeRandomly()
        return ImageRectangle(id: id, x: x, y: y, width: width, height: height, image: url)
    }
    
    static func makeRandomRectangle() -> ColoredRectangle {
        let id = IdentifierFactory.makeTypeRandomly()
        let point = PointFactory.makeTypeRandomly()
        let size = SizeFactory.makeType(width: 150, height: 120)
        let color = ColorFactory.makeTypeRandomly()
        let alpha = Alpha.randomElement()
        
        return ColoredRectangle(id: id, origin: point, size: size, color: color, alpha: alpha)
    }
    
    static func makeRandomRectangle(with image: URL) -> ImageRectangle {
        let id = IdentifierFactory.makeTypeRandomly()
        let point = PointFactory.makeTypeRandomly()
        let size = SizeFactory.makeType(width: 150, height: 120)
        
        return ImageRectangle(id: id, origin: point, size: size, image: image)
    }
}
