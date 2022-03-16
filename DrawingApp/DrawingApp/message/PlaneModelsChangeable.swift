//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation
protocol PlaneModelAddable{
    func addRandomRectnagleViewModel()
    func addRandomPhotoViewModel(imageData: Data)
}

protocol PlaneModelChangeabel{
    func changeRectangleRandomColor()
    func plusCustomViewAlpha()
    func minusCustomViewAlpha()
}

protocol PlaneModelSelectable{
    func selectTargetCustomView(point: ViewPoint)
    func deSelectTargetCustomView()
}

protocol PlaneModelManageable: PlaneModelAddable, PlaneModelChangeabel, PlaneModelSelectable{
    func rectangleCount() -> Int
}
