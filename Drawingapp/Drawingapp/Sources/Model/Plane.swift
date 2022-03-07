//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

protocol PlaneAction {
    func touchPoint(where point: Point)
    func colorChanged(_ color: Color)
    func alphaChanged(_ alpha: Alpha)
}

protocol MakeDrawingItem {
    func makeRectangle()
    func makeRectangle(url: URL)
    func makeRectangle(itemProvider: NSItemProvider)
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
        didMakeRectangle(rectangle: rectangle)
    }
    
    func makeRectangle(url: URL) {
        let rectangle = DrawingModelFactory.makePhotoRectangle(url: url)
        didMakeRectangle(rectangle: rectangle)
    }
    
    func makeRectangle(itemProvider: NSItemProvider) {
        let rectangle = DrawingModelFactory.makePhotoRectangle(itemProvider: itemProvider)
        didMakeRectangle(rectangle: rectangle)
    }
    
    private func didMakeRectangle(rectangle: Rectangle) {
        let userInfo: [AnyHashable : Any] = [ParamKey.rectangle:rectangle]
        NotificationCenter.default.post(name: Plane.EventName.didmakeRectangle, object: nil, userInfo: userInfo)
        
    }
}

extension Plane: PlaneAction {
    func touchPoint(where point: Point) {
        if let selectedRectangle = self.selectedRectangle {
            self.selectedRectangle = nil
            let userInfo: [AnyHashable : Any] = [ParamKey.rectangle:selectedRectangle]
            NotificationCenter.default.post(name: Plane.EventName.didDisSelectedRectangle, object: self, userInfo: userInfo)
        }
        
        if let selectedRectangle = self.selected(point: point) {
            self.selectedRectangle = selectedRectangle
            let userInfo: [AnyHashable : Any] = [ParamKey.rectangle:selectedRectangle]
            NotificationCenter.default.post(name: Plane.EventName.didSelectedRectangle, object: self, userInfo: userInfo)
        }
    }
    
    func colorChanged(_ color: Color) {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(color: color)
    }
    
    func alphaChanged(_ alpha: Alpha) {
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
        static let didmakeRectangle = NSNotification.Name("didmakeRectangle")
    }
    
    enum ParamKey {
        static let rectangle = "rectangle"
    }
}
