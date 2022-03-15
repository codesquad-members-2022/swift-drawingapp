//
//  Plane.swift
//  DrawingApp
//
//  Created by dale on 2022/03/03.
//

import Foundation

class Plane {
    private var rectangles : [Rectangle] = []
    private var selectedRectangle : Rectangle?
    
    enum NotificationName {
        static let addRectangle : Notification.Name = Notification.Name("addRectangle")
        static let searchRectangle : Notification.Name = Notification.Name("searchRectangle")
        static let updateAlpha : Notification.Name = Notification.Name("updateAlpha")
        static let changeColor : Notification.Name = Notification.Name("changeColor")
    }
    
    enum NotificationKeyValue {
        static let rectangle = "rectangle"
        static let index = "index"
        static let alpha = "alpha"
        static let color = "color"
    }
    
    subscript(index: Int) -> Rectangle? {
        if index < rectangleCount {
            let targetRectangle = rectangles[index]
            return targetRectangle
        }
        return nil
    }
    
    var rectangleCount : Int {
        return rectangles.count
    }
    
    func addRectangle(rectangle: Rectangle) {
        self.rectangles.append(rectangle)
        NotificationCenter.default.post(name: Plane.NotificationName.addRectangle, object: self, userInfo: [Plane.NotificationKeyValue.rectangle:rectangle])
    }
    
    func searchRectangle(at position : Position) {
        self.selectedRectangle = nil
        for rectangle in rectangles.reversed() {
            if (rectangle.position.x...(rectangle.position.x + rectangle.size.width)).contains(position.x) && (rectangle.position.y...(rectangle.position.y + rectangle.size.height)).contains(position.y) {
                self.selectedRectangle = rectangle
                break
            }
        }
        guard let targetRectangle = selectedRectangle else {return}
        NotificationCenter.default.post(name: Plane.NotificationName.searchRectangle, object: self, userInfo: [Plane.NotificationKeyValue.rectangle:targetRectangle])
    }
    
    func updateAlphaValue(with alpha: Alpha) {
        self.selectedRectangle?.alpha = alpha
        NotificationCenter.default.post(name: Plane.NotificationName.updateAlpha, object: self, userInfo: [Plane.NotificationKeyValue.alpha:alpha])
    }
    
    func changeRandomColor(to randomColor : Color?) {
        guard let randomColor = randomColor else {return}
        self.selectedRectangle?.backgroundColor = randomColor
        NotificationCenter.default.post(name: Plane.NotificationName.changeColor, object: self, userInfo: [Plane.NotificationKeyValue.color:randomColor])
    }
}
