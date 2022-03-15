//
//  DrawingDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol DrawingDelegate{
    func drawingViewDidChangeColor(rectangle: Rectangle)
    func drawingViewDidUpdateAlpha(customModel: CustomViewEntity)
    func drawingViewDidSelecteRectangle(rectangle: Rectangle)
    func drawingViewDidSelectedPhoto(photo: Photo)
    func drawingViewDidDeselect()
}
