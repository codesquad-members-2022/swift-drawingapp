//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol PlaneDelegate{
    func didAddRandomRectangle(rectangle: Rectangle)
    func didChangedColor(id: String, colorRGB: ColorRGB)
    func didSelectedTarget(id: String, alpha: Double, colorRGB: ColorRGB)
    func deSelectedTarget()
    func didUpdateAlpha(id: String, alpha: Double)
}
