//
//  DrawingDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol DrawingDelegate{
    func drawingViewDidChangeColor(rectangleMutbale: RectangleViewModelMutable)
    func drawingViewDidUpdateAlpha(customViewModelMutable: CustomViewModelMutable)
    func drawingViewDidSelecteRectangle(rectangleMutbale: RectangleViewModelMutable)
    func drawingViewDidSelectedPhoto(photoMutable: PhotoViewModelMutable)
    func drawingViewDidDeselect()
}
