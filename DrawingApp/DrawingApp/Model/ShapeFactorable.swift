//
//  ShapeFactorable.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

protocol ShapeFactorable {
    func createShape(shapeType: ShapeType) -> Shapable
}
