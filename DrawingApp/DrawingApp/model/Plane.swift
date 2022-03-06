//
//  Plane.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

struct Plane{
    private var rectangleFactory = RectangleFactory()
    private var rectangles: [ViewPoint: Rectangle] = [:]
    private var planeDelegate: PlaneDelegate?
    private var selectedRectangle: Rectangle?

    subscript(point: ViewPoint) -> Rectangle?{
        return rectangles[point]
    }
    
    mutating func setDelegate(planeDelegate: PlaneDelegate){
        self.planeDelegate = planeDelegate
    }
    
    mutating func addRectangle(){
        let rectangle = rectangleFactory.makeRandomRectangle()
        rectangles[rectangle.point] = rectangle
        self.selectedRectangle = rectangle
        planeDelegate?.didAddRandomRectangle(rectangle: rectangle)
    }
    
    mutating func selectedRectangle(point: ViewPoint){
        self.selectedRectangle = rectangles[point]
        guard let selectedRectangle = selectedRectangle else { return }
        planeDelegate?.didUpdateAlpha(id: selectedRectangle.uniqueId, alpha: selectedRectangle.alpha)
        planeDelegate?.didSelectedTarget(id: selectedRectangle.uniqueId, alpha: selectedRectangle.alpha, colorRGB: selectedRectangle.color)
    }
    
    mutating func deselectedRectangle(){
        self.selectedRectangle = nil
        planeDelegate?.deSelectedTarget()
    }
    
    mutating func changeColor(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.resetColor(rgbValue: rectangleFactory.makeRandomColor())
        planeDelegate?.didChangedColor(id: selectedRectangle.uniqueId, colorRGB: selectedRectangle.color)
    }
    
    mutating func plusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
        planeDelegate?.didUpdateAlpha(id: selectedRectangle.uniqueId, alpha: selectedRectangle.alpha)
    }
    
    mutating func minusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
        planeDelegate?.didUpdateAlpha(id: selectedRectangle.uniqueId, alpha: selectedRectangle.alpha)
    }
    
    
    mutating func selectedRectangleAlpha() -> Double?{
        return selectedRectangle?.alpha
    }
    
    mutating func selectedRectangleColor() -> ColorRGB?{
        return selectedRectangle?.color
    }
    
    mutating func rectangleCount() -> Int{
        return rectangles.count
    }
    
}
