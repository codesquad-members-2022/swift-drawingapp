//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

protocol PlaneInput {
    func touchPoint(where point: Point)
    func colorChanged()
    func alphaChanged(alpha: Alpha)
}

protocol MakeDrawingItem {
    func makeRectangle()
    func makePhotoRectangle(url: URL)
    
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
        let rectangles = rectangles.reversed()
        for rectangle in rectangles {
            if rectangle.isSelected(by: point) {
                return rectangle
            }
        }
        return nil
    }
}

extension Plane: MakeDrawingItem {
    func makeRectangle() {
        let rectangle = DrawingModelFactory.makeRectangle()
        self.rectangles.append(rectangle)
        let userInfo: [AnyHashable : Any] = ["rectangle":rectangle]
        NotificationCenter.default.post(name: Plane.EventName.madeRectangle, object: self, userInfo: userInfo)
    }
    
    func makePhotoRectangle(url: URL) {
        let rectangle = DrawingModelFactory.makePhotoRectangle(url: url)
        self.rectangles.append(rectangle)
        let userInfo: [AnyHashable : Any] = ["rectangle":rectangle]
        NotificationCenter.default.post(name: Plane.EventName.madeRectangle, object: nil, userInfo: userInfo)
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
    
    func colorChanged() {
        guard let rectangle = self.selectedRectangle,
              let color = ColorFactory.make() else {
            return
        }
        rectangle.update(color: color)
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
