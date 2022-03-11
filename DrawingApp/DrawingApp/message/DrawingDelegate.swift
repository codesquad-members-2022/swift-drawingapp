//
//  DrawingDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol DrawingDelegate{
    func drawingViewDidChangeColor(rectangle: Rectangle)
    func drawingViewDidUpdateAlpha(rectangle: Rectangle)
    func drawingViewDidSelecteRectangle(rectangle: Rectangle)
    func drawingViewDidDeselect()
}
