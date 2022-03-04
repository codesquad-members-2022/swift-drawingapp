//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

protocol PlaneInput {
    func touchPoint(where point: Point)
    func makeRectangle()
    func colorChanged()
    func alphaChanged(alpha: Alpha)
}

class Plane {    
    private var rectangles: [Rectangle] = []
    private var selectedRectangle: Rectangle?
    
    var count: Int {
        rectangles.count
    }
    
    subscript(index: Int) -> Rectangle? {
        if index >= 0 && index <= rectangles.count {
            return rectangles[index]
        }
        return nil
    }
    
    private func selected(point: Point) -> Rectangle? {
        rectangles.filter{ $0.isSelected(by: point) }.last
    }
}

extension Plane: PlaneInput {
    func touchPoint(where point: Point) {
        if let selectedRectangle = self.selectedRectangle {
            NotificationCenter.default.post(name: NSNotification.Name.didDisSelectedRectangle, object: selectedRectangle.id)
            self.selectedRectangle = nil
        }
        
        if let selectedRectangle = self.selected(point: point) {
            self.selectedRectangle = selectedRectangle
            NotificationCenter.default.post(name: NSNotification.Name.didSelectedRectangle, object: selectedRectangle)
        }
    }
    
    func makeRectangle() {
        let rectangle = DrawingModelFactory.makeRectangle()
        self.rectangles.append(rectangle)
        NotificationCenter.default.post(name: NSNotification.Name.drawRectangle, object: rectangle)
    }
    
    func colorChanged() {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(color: ColorFactory.make())
        NotificationCenter.default.post(name: NSNotification.Name.updateColor, object: rectangle.id, userInfo: ["color": rectangle.color])
    }
    
    func alphaChanged(alpha: Alpha) {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(alpha: alpha)
        NotificationCenter.default.post(name: NSNotification.Name.updateAlpha, object: rectangle.id, userInfo: ["alpha": rectangle.alpha])
    }
    
}
