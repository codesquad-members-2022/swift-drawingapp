//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/16.
//
//

import Foundation

enum ShapeViewFactory {
    static func makeView(ofClass type: ShapeViewable.Type, with data: Shapable) -> ShapeViewable? {
        switch type {
        case is ColoredRectangleView.Type:
            return RectangleViewFactory.makeView(ofClass: ColoredRectangleView.self, with: data)
        case is ImageRectangleView.Type:
            return RectangleViewFactory.makeView(ofClass: ImageRectangleView.self, with: data)
        default:
            return nil
        }
    }
}
