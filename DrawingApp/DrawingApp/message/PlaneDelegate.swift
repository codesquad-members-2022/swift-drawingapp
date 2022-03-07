//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol PlaneDelegate{
    mutating func didAddRandomRectangle() -> Rectangle
    func didChangedColor() -> Rectangle?
    mutating func didSelectedTarget(point: ViewPoint)-> Rectangle?
    mutating func deSelectedTarget()
    func didUpdateAlpha(changed: RectangleAlphaChange) -> Rectangle?
}
