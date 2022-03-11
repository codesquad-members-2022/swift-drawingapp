//
//  Plane.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation

class Plane {
    private var rectangles = [Rectangle]()
    private var specifiedRectangle: Rectangle?
    private let notificationCenter = NotificationCenter.default
    static let didAddRectangle = Notification.Name("PlaneDidAddRectangle")
    static let didSpecifyRectangle = Notification.Name("PlaneDidSpecifyRectangle")
    static let didChangeRectangleBackgroundColor = Notification.Name("PlaneDidChangeRectangleBackgroundColor")
    static let didChangeRectangleAlpha = Notification.Name("PlaneDidChangeRectangleAlpha")
    static let changedRectangle = "ChangedRectangle"
    static let specifiedRectangle = "specifiedRectangle"
    static let addedRectangle = "addedRectanlge"
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    public func specifyRectangle(point: Point) -> Result<Rectangle, PlaneError> {
        for rectangle in rectangles.reversed() {
            if rectangle.isPointInArea(point) {
                self.specifiedRectangle = rectangle
                notificationCenter.post(name: Plane.didSpecifyRectangle, object: self, userInfo: [Plane.specifiedRectangle: rectangle])
                return .success(rectangle)
            }
        }
        self.specifiedRectangle = nil
        notificationCenter.post(name: Plane.didSpecifyRectangle, object: self)
        return .failure(.cannotSpecifyRectangleError)
    }
    
    public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        notificationCenter.post(name: Plane.didAddRectangle, object: self, userInfo: [Plane.addedRectangle: newRectangle])
    }
    
    public func changeBackgroundColor(to newColor: BackgroundColor) -> Result<Rectangle, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeBackgroundColor(to: newColor)
        notificationCenter.post(name: Plane.didChangeRectangleBackgroundColor, object: self, userInfo: [Plane.changedRectangle: specifiedRectangle])
        return .success(specifiedRectangle)
    }

    public func changeAlphaValue(to newAlpha: Alpha) -> Result<Rectangle, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeAlphaValue(to: newAlpha)
        notificationCenter.post(name: Plane.didChangeRectangleAlpha, object: self, userInfo: [Plane.changedRectangle: specifiedRectangle])
        return .success(specifiedRectangle)
    }

}

enum PlaneError: Error {
    case cannotSpecifyRectangleError
    case noSpecifiedRectangleToChangeError
}
