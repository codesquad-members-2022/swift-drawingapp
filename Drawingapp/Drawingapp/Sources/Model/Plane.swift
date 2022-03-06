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
            self.selectedRectangle = nil
            let userInfo: [AnyHashable : Any] = ["id":selectedRectangle.id]
            NotificationCenter.default.post(name: Plane.EventName.didDisSelectedRectangle, object: self, userInfo: userInfo)
        }
        
        if let selectedRectangle = self.selected(point: point) {
            self.selectedRectangle = selectedRectangle
            let userInfo: [AnyHashable : Any] = ["rectangle":selectedRectangle]
            NotificationCenter.default.post(name: Plane.EventName.didSelectedRectangle, object: self, userInfo: userInfo)
        }
    }
    
    func makeRectangle() {
        let rectangle = DrawingModelFactory.makeRectangle()
        self.rectangles.append(rectangle)
        let userInfo: [AnyHashable : Any] = ["rectangle":rectangle]
        NotificationCenter.default.post(name: Plane.EventName.madeRectangle, object: self, userInfo: userInfo)
    }
    
    func colorChanged() {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(color: ColorFactory.make())
    }
    
    func alphaChanged(alpha: Alpha) {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(alpha: alpha)
    }
    
}

extension Plane {
    enum EventName {
        static let didDisSelectedRectangle = NSNotification.Name("didDisSelectedRectangle")
        static let didSelectedRectangle = NSNotification.Name("didSelectedRectangle")
        static let madeRectangle = NSNotification.Name("makeRectangle")
    }
}
