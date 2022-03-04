//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class ShapeFactory: ShapeCreator {
    func createShape(shapeType: ShapeType, size: Size, point: Point, color: BackgroundColor, alpha: Int) -> Shape {
        switch shapeType {
        case .rectangle:
            return Rectangle(size: size, point: point, backgroundColor: color, alpha: alpha)
        }
    }
}
