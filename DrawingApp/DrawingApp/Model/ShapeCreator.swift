//
//  ShapeCreator.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

protocol ShapeCreator {
    func createRectangle(point: Point, size: Size, color: Color, alpha: Alpha) -> Shape
}
