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
    
    func selectedRectangle(point: ViewPoint){
        self.selectedRectangle = rectangles[point]
    }
    
    func deselectedRectangle(){
        self.selectedRectangle = nil
    }
    
    func plusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
    }
    
    func minusAlpha(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
    }
    
    func rectangleCount() -> Int{
        return rectangles.count
    }
    
}
extension Plane: RectangleChangeable{
    func addRandomRectangle(){
        let rectangle = rectangleFactory.randomRectangle()
        self.rectangles[rectangle.point] = rectangle
        self.selectedRectangle = rectangle
        NotificationCenter.default.post(name: Plane.NotiEvent.addedRectangle, object: self, userInfo: [PlaneNotificationKey.rectangle : rectangle])
    }
    
    func changeRectangleRandomColor(){
        guard let selectedRectangle = selectedRectangle else { return }
        selectedRectangle.resetColor(rgbValue: rectangleFactory.randomRGBColor())
        NotificationCenter.default.post(name: Plane.NotiEvent.changedRectangleColor, object: self, userInfo:  [PlaneNotificationKey.rectangle : selectedRectangle])
    }
    
    func selectTargetRectangle(point: ViewPoint){
        self.selectedRectangle = rectangles[point]
        guard let selectedRectangle = selectedRectangle else { return }
        NotificationCenter.default.post(name: Plane.NotiEvent.selectedRectangle, object: self, userInfo:  [PlaneNotificationKey.rectangle : selectedRectangle])
    }
    
    func deSelectTargetRectangle(){
        self.selectedRectangle = nil
        NotificationCenter.default.post(name: Plane.NotiEvent.deselectedRectangle, object: self)
    }
    
    func changeRectangleAlpha(changed: RectangleAlphaChange){
        guard let selectedRectangle = selectedRectangle else { return }
        switch changed{
        case .plus: selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha + 0.1)
        case .minus: selectedRectangle.changeAlphaValue(alpha: selectedRectangle.alpha - 0.1)
        case .none: break
        }
        NotificationCenter.default.post(name: Plane.NotiEvent.updateRectangleAlpha, object: self, userInfo: [PlaneNotificationKey.rectangle : selectedRectangle])
    }
    
    enum NotiEvent{
        static let addedRectangle = Notification.Name.init("addedRectangle")
        static let selectedRectangle = Notification.Name.init("selectedRectangle")
        static let deselectedRectangle = Notification.Name.init("deselectedRectangle")
        static let changedRectangleColor = Notification.Name.init("changedRectangleColor")
        static let updateRectangleAlpha = Notification.Name.init("updateRectangleAlpha")
    }
}

enum RectangleAlphaChange{
    case plus
    case minus
    case none
}

enum PlaneNotificationKey{
    case rectangle
}
