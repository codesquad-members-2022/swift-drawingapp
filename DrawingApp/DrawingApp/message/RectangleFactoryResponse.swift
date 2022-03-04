//
//  MoveRectangle.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

protocol RectangleFactoryResponse{
    func randomRectangle(rectangle: Rectangle)
    func randomRGBColor(rgb: ColorRGB)
}
