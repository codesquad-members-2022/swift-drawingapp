//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol PlaneDelegate{
    mutating func didAddRandomRectangle()
    func didChangedColor()
    mutating func didSelectedTarget(point: ViewPoint)
    mutating func deSelectedTarget()
    func didUpdateAlpha(changed: RectangleAlphaChange)
}
