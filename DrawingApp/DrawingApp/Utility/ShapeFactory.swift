//
//  ShapeFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

enum ShapeFactory: ShapeBuildable {
    static func makeShape(ofClass type: Shapable.Type) -> Shapable? {
        switch type {
        case is ColoredRectangle.Type:
            return RectangleFactory.makeShape(ofClass: ColoredRectangle.self)
        case is ImageRectangle.Type:
            return RectangleFactory.makeShape(ofClass: ImageRectangle.self)
        default:
            return nil
        }
    }
}
