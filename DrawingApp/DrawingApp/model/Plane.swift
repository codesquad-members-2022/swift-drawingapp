//
//  Plane.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

struct Plane{
    private var rectangleFactory: RectangleFactoryResponse
    private var rectangles: [ViewPoint: Rectangle] = [:]
    private var selectedRectangle: Rectangle?

    subscript(point: ViewPoint) -> Rectangle?{
        return rectangles[point]
    }
    
    init(){
        rectangleFactory = RectangleFactory()
    }
    
    mutating func addRectangle(){
        let rectangle = rectangleFactory.randomRectangle()
        rectangles[rectangle.point] = rectangle
        self.selectedRectangle = rectangle
    }
    
    mutating func selectedRectangle(point: ViewPoint){
        self.selectedRectangle = rectangles[point]
        guard let selectedRectangle = selectedRectangle else { return }
    }
    
    mutating func deselectedRectangle(){
        self.selectedRectangle = nil
    }
    
    mutating func changeColor(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.resetColor(rgbValue: rectangleFactory.randomRGBColor())
    }
    
    mutating func plusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
    }
    
    mutating func minusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
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
extension Plane: PlaneDelegate{
    mutating func didAddRandomRectangle() -> Rectangle {
        let rectangle = rectangleFactory.randomRectangle()
        self.rectangles[rectangle.point] = rectangle
        self.selectedRectangle = rectangle
        return rectangle
    }
    
    func didChangedColor() -> Rectangle? {
        guard let selectedRectangle = selectedRectangle else { return nil }
        selectedRectangle.resetColor(rgbValue: rectangleFactory.randomRGBColor())
        return selectedRectangle
    }
    
    mutating func didSelectedTarget(point: ViewPoint)-> Rectangle? {
        self.selectedRectangle = rectangles[point]
        guard let selectedRectangle = selectedRectangle else { return nil }
        return selectedRectangle
    }
    
    mutating func deSelectedTarget() {
        self.selectedRectangle = nil
    }
    
    func didUpdateAlpha(changed: RectangleAlphaChange) -> Rectangle? {
        guard let selectedRectangle = selectedRectangle else { return nil }
        switch changed{
        case .plus: selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
        case .minus: selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
        case .none: break
        default: break
        }
        return selectedRectangle
    }
}

enum RectangleAlphaChange{
    case plus
    case minus
    case none
}
