//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class ShapeFactory: ShapeCreator {

    func createRectangle(point: Point, size: Size, color: Color, alpha: Alpha) -> Shape {
        let id = generateId()
        return Rectangle(id: id, point: point, size: size, color: color, alpha: alpha)
    }
    
    private func generateId() -> String {
        return UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3) + "-" + UUID().uuidString.prefix(3)
    }
}
