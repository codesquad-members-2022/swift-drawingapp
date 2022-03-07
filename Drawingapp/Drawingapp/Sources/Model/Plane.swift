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
        rectangles.filter{ $0.isSelected(by: point) }.last
    }
}

extension Plane: MakeDrawingItem {
    func makeRectangle() {
        let rectangle = DrawingModelFactory.makeRectangle()
        self.rectangles.append(rectangle)
        let userInfo: [AnyHashable : Any] = ["rectangle":rectangle]
        NotificationCenter.default.post(name: NSNotification.Name.drawRectangle, object: nil, userInfo: userInfo)
    }
    
    func makePhotoRectangle(url: URL) {
        let rectangle = DrawingModelFactory.makePhotoRectangle(url: url)
        self.rectangles.append(rectangle)
        let userInfo: [AnyHashable : Any] = ["rectangle":rectangle]
        NotificationCenter.default.post(name: NSNotification.Name.drawRectangle, object: nil, userInfo: userInfo)
    }
}

extension Plane: PlaneInput {
    func touchPoint(where point: Point) {
        if let selectedRectangle = self.selectedRectangle {
<<<<<<< HEAD
=======
            let userInfo: [AnyHashable : Any] = ["id":selectedRectangle.id]
            NotificationCenter.default.post(name: NSNotification.Name.didDisSelectedRectangle, object: nil, userInfo: userInfo)
>>>>>>> 86d216a ([feature] 사진첩에서 사진 선택하면 포토 뷰 생김)
            self.selectedRectangle = nil
            let userInfo: [AnyHashable : Any] = ["id":selectedRectangle.id]
            NotificationCenter.default.post(name: Plane.EventName.didDisSelectedRectangle, object: self, userInfo: userInfo)
        }
        
        if let selectedRectangle = self.selected(point: point) {
            self.selectedRectangle = selectedRectangle
            let userInfo: [AnyHashable : Any] = ["rectangle":selectedRectangle]
<<<<<<< HEAD
            NotificationCenter.default.post(name: Plane.EventName.didSelectedRectangle, object: self, userInfo: userInfo)
        }
    }
    
    func makeRectangle() {
        let rectangle = DrawingModelFactory.makeRectangle()
        self.rectangles.append(rectangle)
        let userInfo: [AnyHashable : Any] = ["rectangle":rectangle]
        NotificationCenter.default.post(name: Plane.EventName.madeRectangle, object: self, userInfo: userInfo)
    }
    
=======
            NotificationCenter.default.post(name: NSNotification.Name.didSelectedRectangle, object: nil, userInfo: userInfo)
        }
    }
    
>>>>>>> 86d216a ([feature] 사진첩에서 사진 선택하면 포토 뷰 생김)
    func colorChanged() {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(color: ColorFactory.make())
<<<<<<< HEAD
=======
        let userInfo: [AnyHashable : Any] = ["id":rectangle.id, "color":rectangle.color]
        NotificationCenter.default.post(name: NSNotification.Name.updateColor, object: nil, userInfo: userInfo)
>>>>>>> 86d216a ([feature] 사진첩에서 사진 선택하면 포토 뷰 생김)
    }
    
    func alphaChanged(alpha: Alpha) {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(alpha: alpha)
<<<<<<< HEAD
=======
        let userInfo: [AnyHashable : Any] = ["id":rectangle.id, "alpha":rectangle.alpha]
        NotificationCenter.default.post(name: NSNotification.Name.updateAlpha, object: nil, userInfo: userInfo)
>>>>>>> 86d216a ([feature] 사진첩에서 사진 선택하면 포토 뷰 생김)
    }
    
}

extension Plane {
    enum EventName {
        static let didDisSelectedRectangle = NSNotification.Name("didDisSelectedRectangle")
        static let didSelectedRectangle = NSNotification.Name("didSelectedRectangle")
        static let madeRectangle = NSNotification.Name("makeRectangle")
    }
}
