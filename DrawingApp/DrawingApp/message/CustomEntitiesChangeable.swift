//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol CustomEntitiesChangeable{
    func addRandomRectnagle()
    func addRandomPhoto(imageData: Data)
    func changeRectangleRandomColor()
    func selectTargetCustomView(point: ViewPoint)
    func deSelectTargetCustomView()
    func plusCustomViewAlpha()
    func CustomViewAlpha()
    func rectangleCount() -> Int
}
