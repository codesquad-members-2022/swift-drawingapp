//
//  Plane.swift
//  DrawingApp
//
//  Created by dale on 2022/03/03.
//

import Foundation
import UIKit

class Plane {
    private var rectangles : [Rectangle] = []
    private var selectedRectangle : Rectangle?
    static let addRectangle : Notification.Name = Notification.Name("addRectangle")
    static let searchRectangle : Notification.Name = Notification.Name("searchRectangle")
    static let updateAlpha : Notification.Name = Notification.Name("updateAlpha")
    
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
        NotificationCenter.default.post(name: Plane.addRectangle, object: self, userInfo: ["rectangle":rectangle])
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
        if let selectedIndex = rectangles.lastIndex(of: targetRectangle) {
            NotificationCenter.default.post(name: Plane.searchRectangle, object: self, userInfo: ["rectangle":targetRectangle, "index": selectedIndex])
        }
    }
    
    func updateAlphaValue(with alpha: Alpha) {
        self.selectedRectangle?.alpha = alpha
        NotificationCenter.default.post(name: Plane.updateAlpha, object: self, userInfo: ["alpha":alpha])
    }
    
    func changeRandomColor(to randomColor : Color?) {
        guard let randomColor = randomColor else {return}
        self.selectedRectangle?.backGroundColor = randomColor
    }
}
