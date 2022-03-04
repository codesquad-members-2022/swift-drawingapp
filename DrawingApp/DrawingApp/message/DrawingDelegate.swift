//
//  DrawingDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol DrawingDelegate{
    func changedColor(rectangleRGB: ColorRGB)
    func updatedAlpha(alpha: Double)
    func defaultProperty(alpha: Double, rectangleRGB: ColorRGB)
    func deselected()
}
