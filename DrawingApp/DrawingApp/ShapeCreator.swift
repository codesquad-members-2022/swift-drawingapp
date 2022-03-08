//
//  ShapeCreator.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

protocol ShapeCreator {
    func createShape(shapeType: ShapeType, point: Point, size: Size, color: Color, alpha: Int) -> Shape
}

enum ShapeType {
    case rectangle
}
