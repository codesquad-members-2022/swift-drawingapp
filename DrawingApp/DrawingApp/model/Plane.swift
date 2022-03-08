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
    
    mutating func selectedRectangle(point: ViewPoint){
        self.selectedRectangle = rectangles[point]
    }
    
    mutating func deselectedRectangle(){
        self.selectedRectangle = nil
    }
    
    func changeColor(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.resetColor(rgbValue: rectangleFactory.randomRGBColor())
    }
    
    func plusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
    }
    
    func minusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
    }
    
    func selectedRectangleAlpha() -> Double?{
        return selectedRectangle?.alpha
    }
    
    func selectedRectangleColor() -> ColorRGB?{
        return selectedRectangle?.color
    }
    
    func rectangleCount() -> Int{
        return rectangles.count
    }
}
extension Plane: PlaneDelegate{
    mutating func didAddRandomRectangle(){
        let rectangle = rectangleFactory.randomRectangle()
        self.rectangles[rectangle.point] = rectangle
        self.selectedRectangle = rectangle
        NotificationCenter.default.post(name: .addedRectangle, object: rectangle)
    }
    
    func didChangedColor(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.resetColor(rgbValue: rectangleFactory.randomRGBColor())
        NotificationCenter.default.post(name: .changedRectangleColor, object: selectedRectangle)
    }
    
    mutating func didSelectedTarget(point: ViewPoint){
        self.selectedRectangle = rectangles[point]
        guard let selectedRectangle = selectedRectangle else { return }
        NotificationCenter.default.post(name: .selectedRectangle, object: selectedRectangle)
    }
    
    mutating func deSelectedTarget(){
        self.selectedRectangle = nil
        NotificationCenter.default.post(name: .deselectedRectangle, object: nil)
    }
    
    func didUpdateAlpha(changed: RectangleAlphaChange){
        guard let selectedRectangle = selectedRectangle else { return }
        switch changed{
        case .plus: selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
        case .minus: selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
        case .none: break
        }
        NotificationCenter.default.post(name: .updateRectangleAlpha, object: selectedRectangle)
    }
}

enum RectangleAlphaChange{
    case plus
    case minus
    case none
}
