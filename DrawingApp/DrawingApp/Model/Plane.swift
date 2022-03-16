//
//  Plane.swift
//  DrawingApp
//
//  Created by dale on 2022/03/03.
//

import Foundation

class Plane {
    private var shapes : [Shape] = []
    private var selectedShape : Shape?
    
    enum NotificationName {
        static let addShape : Notification.Name = Notification.Name("addShape")
        static let searchShape : Notification.Name = Notification.Name("searchShape")
        static let updateAlpha : Notification.Name = Notification.Name("updateAlpha")
        static let changeColor : Notification.Name = Notification.Name("changeColor")
    }
    
    enum NotificationKeyValue {
        static let shape = "shape"
        static let index = "index"
        static let alpha = "alpha"
        static let color = "color"
    }
    
    subscript(index: Int) -> Shape? {
        if index < shapeCount {
            let targetShape = shapes[index]
            return targetShape
        }
        return nil
    }
    
    var shapeCount : Int {
        return shapes.count
    }
    
    func addShape(shape: Shape) {
        self.shapes.append(shape)
        NotificationCenter.default.post(name: Plane.NotificationName.addShape, object: self, userInfo: [Plane.NotificationKeyValue.shape:shape])
    }
    
    func searchShape(at position : Position) {
        self.selectedShape = nil
        for shape in shapes.reversed() {
            if (shape.position.x...(shape.position.x + shape.size.width)).contains(position.x) && (shape.position.y...(shape.position.y + shape.size.height)).contains(position.y) {
                self.selectedShape = shape
                break
            }
        }
        NotificationCenter.default.post(name: Plane.NotificationName.searchShape, object: self, userInfo: [Plane.NotificationKeyValue.shape:self.selectedShape])
    }
    
    func updateAlphaValue(with alpha: Alpha) {
        self.selectedShape?.setAlpha(to: alpha)
        NotificationCenter.default.post(name: Plane.NotificationName.updateAlpha, object: self, userInfo: [Plane.NotificationKeyValue.alpha:alpha])
    }
    
    func changeRandomColor(to randomColor : Color) {
        guard let rectangle = self.selectedShape as? Rectangle else {return}
        rectangle.setBackgroundColor(to: randomColor)
        NotificationCenter.default.post(name: Plane.NotificationName.changeColor, object: self, userInfo: [Plane.NotificationKeyValue.color:randomColor])
    }
}
