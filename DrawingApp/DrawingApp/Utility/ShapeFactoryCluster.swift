//
//  ShapeFactoryCluster.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

protocol ShapeFactory {
    static func makeShape(with type: Shapable.Type) -> Shapable?
}

enum ShapeFactoryCluster: ShapeFactory {
    static func makeShape(with type: Shapable.Type) -> Shapable? {
        switch type {
        case is Rectangle.Type:
            return RectangleFactory.makeShape()
        default:
            return nil
        }
    }
}
