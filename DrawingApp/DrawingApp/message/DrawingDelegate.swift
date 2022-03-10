//
//  DrawingDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol DrawingDelegate{
    func changedColor(rectangle: Rectangle)
    func updatedAlpha(rectangle: Rectangle)
    func selectedRectangle(rectangle: Rectangle)
    func deselected()
}
