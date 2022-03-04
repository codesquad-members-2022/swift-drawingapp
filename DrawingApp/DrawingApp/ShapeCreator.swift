//
//  ShapeCreator.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

protocol ShapeCreator {
    func createShape(shapeType: ShapeType, size: Size, point: Point, color: BackgroundColor, alpha: Int) -> Shape
}

enum ShapeType {
    case rectangle
}
