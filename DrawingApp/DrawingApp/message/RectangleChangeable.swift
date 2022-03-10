//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol RectangleChangeable{
    mutating func addRandomRectangle()
    func changeRectangleRandomColor()
    mutating func selectTargetRectangle(point: ViewPoint)
    mutating func deSelectTargetRectangle()
    func changeRectangleAlpha(changed: RectangleAlphaChange)
}
