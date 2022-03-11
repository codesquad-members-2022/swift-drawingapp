//
//  Plane.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/03.
//

import Foundation

class Plane {
    struct NotificationNames {
        static let didAddRectangle = Notification.Name("PlaneDidAddRectangle")
        static let didSpecifyRectangle = Notification.Name("PlaneDidSpecifyRectangle")
        static let didChangeRectangleBackgroundColor = Notification.Name("PlaneDidChangeRectangleBackgroundColor")
        static let didChangeRectangleAlpha = Notification.Name("PlaneDidChangeRectangleAlpha")
    }
    
    struct UserIDKeys {
        static let changedRectangle = "changedRectangle"
        static let specifiedRectangle = "specifiedRectangle"
        static let addedRectangle = "addedRectangle"
    }
    
    private var rectangles = [Rectangularable]()
    private var specifiedRectangle: Rectangularable?
    private let notificationCenter = NotificationCenter.default
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ point: Point) -> Rectangularable? {
        for rectangle in rectangles.reversed() {
            if rectangle.isPointInArea(point) {
                return rectangle
            }
        }
        return nil
    }
    
    public func specifyRectangle(point: Point) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = self[point] else {
            self.specifiedRectangle = nil
            notificationCenter.post(name: Plane.NotificationNames.didSpecifyRectangle, object: self)
            return .failure(.cannotSpecifyRectangleError)
        }
        
        self.specifiedRectangle = specifiedRectangle
        notificationCenter.post(name: Plane.NotificationNames.didSpecifyRectangle, object: self, userInfo: [Plane.UserIDKeys.specifiedRectangle: specifiedRectangle])
        return .success(specifiedRectangle)
    }
    
    public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        notificationCenter.post(name: Plane.NotificationNames.didAddRectangle, object: self, userInfo: [Plane.UserIDKeys.addedRectangle: newRectangle])
    }
    
    public func changeBackgroundColor(to newColor: BackgroundColor) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeBackgroundColor(to: newColor)
        notificationCenter.post(name: Plane.NotificationNames.didChangeRectangleBackgroundColor, object: self, userInfo: [Plane.UserIDKeys.changedRectangle: specifiedRectangle])
        return .success(specifiedRectangle)
    }

    public func changeAlphaValue(to newAlpha: Alpha) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeAlphaValue(to: newAlpha)
        notificationCenter.post(name: Plane.NotificationNames.didChangeRectangleAlpha, object: self, userInfo: [Plane.UserIDKeys.changedRectangle: specifiedRectangle])
        return .success(specifiedRectangle)
    }

}

enum PlaneError: Error {
    case cannotSpecifyRectangleError
    case noSpecifiedRectangleToChangeError
}
