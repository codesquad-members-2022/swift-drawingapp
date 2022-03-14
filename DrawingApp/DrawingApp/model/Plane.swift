//
//  Plane.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

class Plane{
    private var rectangleFactory: RectangleFactoryResponse
    private var rectangles: [ViewPoint: Rectangle] = [:]
    private(set) var selectedRectangle: Rectangle?
    
    subscript(point: ViewPoint) -> Rectangle?{
        return rectangles[point]
    }
    
    init(rectangleFactory: RectangleFactoryResponse){
        self.rectangleFactory = rectangleFactory
    }
    
    private func addRectangle() -> Rectangle{
        let rectangleMutable = rectangleFactory.randomRectangle()
        let rectangle = rectangleMutable.getRandomRectangle()
        self.rectangles[rectangle.point] = rectangle
        self.selectedRectangle = rectangle
        return rectangle
    }
    
    private func changeRectangleColor(){
        let colorMuatble = rectangleFactory.randomRGBColor()
        let rgbValue = colorMuatble.getRandomColorRGb()
        selectedRectangle?.resetColor(rgbValue: rgbValue)
    }
    
    private func selectedRectangle(point: ViewPoint){
        self.selectedRectangle = rectangles[point]
    }
    
    private func deselectedRectangle(){
        self.selectedRectangle = nil
    }
    
    private func plusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
    }
    
    private func minusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
    }
    
}
extension Plane: RectangleChangeable{
    func addRandomRectangle(){
        NotificationCenter.default.post(name: Plane.Notification.Event.addedRectangle, object: self, userInfo: [Plane.Notification.Key.rectangle : addRectangle()])
    }
    
    func changeRectangleRandomColor(){
        guard let selectedRectangle = self.selectedRectangle else { return }
        changeRectangleColor()
        NotificationCenter.default.post(name: Plane.Notification.Event.changedRectangleColor, object: self, userInfo:  [Plane.Notification.Key.rectangle : selectedRectangle])
    }
    
    func selectTargetRectangle(point: ViewPoint){
        selectedRectangle(point: point)
        guard let selectedRectangle = selectedRectangle else { return }
        NotificationCenter.default.post(name: Plane.Notification.Event.selectedRectangle, object: self, userInfo:  [Plane.Notification.Key.rectangle : selectedRectangle])
    }
    
    func deSelectTargetRectangle(){
        deselectedRectangle()
        NotificationCenter.default.post(name: Plane.Notification.Event.deselectedRectangle, object: self)
    }
    
    func pluseRectangleAlpha() {
        guard let selectedRectangle = selectedRectangle else { return }
        plusAlpha()
        NotificationCenter.default.post(name: Plane.Notification.Event.updateRectangleAlpha, object: self, userInfo: [Plane.Notification.Key.rectangle : selectedRectangle])
    }
    
    func minusRectangleAlpha() {
        guard let selectedRectangle = selectedRectangle else { return }
        minusAlpha()
        NotificationCenter.default.post(name: Plane.Notification.Event.updateRectangleAlpha, object: self, userInfo: [Plane.Notification.Key.rectangle : selectedRectangle])
    }
    
    func rectangleCount() -> Int{
        return rectangles.count
    }
    
    enum Notification{
        enum Key{
            case rectangle
        }
        enum Event{
            static let addedRectangle = Foundation.Notification.Name.init("addedRectangle")
            static let selectedRectangle = Foundation.Notification.Name.init("selectedRectangle")
            static let deselectedRectangle = Foundation.Notification.Name.init("deselectedRectangle")
            static let changedRectangleColor = Foundation.Notification.Name.init("changedRectangleColor")
            static let updateRectangleAlpha = Foundation.Notification.Name.init("updateRectangleAlpha")
        }
    }
}
