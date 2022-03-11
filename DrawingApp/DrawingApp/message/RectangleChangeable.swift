//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol RectangleChangeable{
    func addRandomRectangle()
    func changeRectangleRandomColor()
    func selectTargetRectangle(point: ViewPoint)
    func deSelectTargetRectangle()
    func pluseRectangleAlpha()
    func minusRectangleAlpha()
    func rectangleCount() -> Int
}
