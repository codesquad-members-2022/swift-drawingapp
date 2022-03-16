//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol PlaneModelsChangeable{
    func addRandomRectnagleViewModel()
    func addRandomPhotoViewModel(imageData: Data)
    func changeRectangleRandomColor()
    func selectTargetCustomView(point: ViewPoint)
    func deSelectTargetCustomView()
    func plusCustomViewAlpha()
    func minusCustomViewAlpha()
    func rectangleCount() -> Int
}
