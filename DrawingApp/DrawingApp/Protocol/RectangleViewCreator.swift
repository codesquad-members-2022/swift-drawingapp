//
//  RectangleViewCreator.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/15.
//

protocol RectangleViewCreator {
    static func makeRectangleView(sourceRectangle:Rectangleable) -> RectangleViewable
}
