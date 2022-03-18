//
//  ShapeFactoryCluster.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

enum ShapeFactoryCluster: ShapeBuildable {
    static func makeShape(ofClass type: Shapable.Type) -> Shapable? {
        switch type {
        case is ColoredRectangle.Type:
            return RectangleFactory.makeColoredRectangle()
        case is ImageRectangle.Type:
            return RectangleFactory.makeImageRectangle()
        default:
            return nil
        }
    }
}
