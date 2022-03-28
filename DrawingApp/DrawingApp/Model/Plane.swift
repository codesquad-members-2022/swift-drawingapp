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
        static let didAddPhoto = Notification.Name("PlaneDidAddPhoto")
        static let didSpecifyRectangle = Notification.Name("PlaneDidSpecifyRectangle")
        static let didChangeRectangleBackgroundColor = Notification.Name("PlaneDidChangeRectangleBackgroundColor")
        static let didChangeRectangleAlpha = Notification.Name("PlaneDidChangeRectangleAlpha")
        static let didChangeRectanglePoint = Notification.Name("PlaneDidChangeRectanglePoint")
        static let didChangeRectangleSize = Notification.Name("PlaneDidChangeRectangleSize")
    }
    
    struct UserInfoKeys {
        static let changedRectangle = "changedRectangle"
        static let specifiedRectangle = "specifiedRectangle"
        static let addedRectangle = "addedRectangle"
        static let addedPhoto = "addedPhoto"
    }
    
    private var rectangles = [Rectangularable]()
    private var specifiedRectangle: Rectangularable?
    var count: Int {
        return rectangles.count
    }
    
    subscript(_ index: Int) -> Rectangularable? {
        return rectangles[index]
    }
    
    public func specifyRectangle(point: Point) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = findRectangle(above: point)  else {
            self.specifiedRectangle = nil
            NotificationCenter.default.post(name: Plane.NotificationNames.didSpecifyRectangle, object: self)
            return .failure(.cannotSpecifyRectangleError)
        }
        self.specifiedRectangle = specifiedRectangle
        NotificationCenter.default.post(name: Plane.NotificationNames.didSpecifyRectangle, object: self, userInfo: [Plane.UserInfoKeys.specifiedRectangle: specifiedRectangle])
        return .success(specifiedRectangle)
    }
    
    public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        NotificationCenter.default.post(name: Plane.NotificationNames.didAddRectangle, object: self, userInfo: [Plane.UserInfoKeys.addedRectangle: newRectangle])
    }
    
    public func addNewPhoto(in frame: (width: Double, height: Double), with newImage: Data) {
        let newPhoto = RectangleFactory.makePhoto(in: frame, image: newImage)
        rectangles.append(newPhoto)
        NotificationCenter.default.post(name: Plane.NotificationNames.didAddPhoto, object: self, userInfo: [Plane.UserInfoKeys.addedPhoto: newPhoto])
    }
    
    public func changeBackgroundColor(to newColor: BackgroundColor) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        
        if let specifiedRectangle = specifiedRectangle as? ModelBackgroundColorChangable {
            specifiedRectangle.changeBackgroundColor(to: newColor)
            NotificationCenter.default.post(name: Plane.NotificationNames.didChangeRectangleBackgroundColor, object: self, userInfo: [Plane.UserInfoKeys.changedRectangle: specifiedRectangle])
        }
       
        return .success(specifiedRectangle)
    }

    public func changeAlphaValue(to newAlpha: Alpha) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeAlphaValue(to: newAlpha)
        NotificationCenter.default.post(name: Plane.NotificationNames.didChangeRectangleAlpha, object: self, userInfo: [Plane.UserInfoKeys.changedRectangle: specifiedRectangle])
        return .success(specifiedRectangle)
    }
    
    public func changePoint(to newPoint: Point) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        let validatedPoint = validatePoint(newPoint)
        specifiedRectangle.move(to: validatedPoint)
        NotificationCenter.default.post(name: Plane.NotificationNames.didChangeRectanglePoint, object: self, userInfo: [Plane.UserInfoKeys.changedRectangle: specifiedRectangle])
        
        return .success(specifiedRectangle)
    }
    
    public func changeSize(to newSize: Size) -> Result<Rectangularable, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.resize(to: newSize)
        NotificationCenter.default.post(name: Plane.NotificationNames.didChangeRectangleSize, object: self, userInfo: [Plane.UserInfoKeys.changedRectangle: specifiedRectangle])
        
        return .success(specifiedRectangle)
    }
    
    private func findRectangle(above point: Point) -> Rectangularable? {
        return rectangles.reversed().first { rectangle in
            rectangle.isPointInArea(point)
        }
    }
    
    private func validatePoint(_ point: Point) -> Point {
        var newX: Double, newY: Double
        
        newX = point.x < 1.0 ? 1.0 : point.x
        newY = point.y < 1.0 ? 1.0 : point.y
        
        return Point(x: newX, y: newY)
    }

}

enum PlaneError: Error {
    case cannotSpecifyRectangleError
    case noSpecifiedRectangleToChangeError
}
