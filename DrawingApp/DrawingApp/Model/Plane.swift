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
                notificationCenter.post(name: ViewController.planeDidSpecifyRectangle, object: self, userInfo: [K.PlaneRectangle.specified: rectangle])
                return .success(rectangle)
            }
        }
        self.specifiedRectangle = nil
        notificationCenter.post(name: ViewController.planeDidSpecifyRectangle, object: self)
        return .failure(.cannotSpecifyRectangleError)
    }
    
    public func addNewRectangle(in frame: (width: Double, height: Double)) {
        let newRectangle = RectangleFactory.makeRandomRectangle(in: frame)
        rectangles.append(newRectangle)
        notificationCenter.post(name: ViewController.planeDidAddRectangle, object: self, userInfo: [K.PlaneRectangle.added: newRectangle])
    }
    
    public func changeBackgroundColor(to newColor: BackgroundColor) -> Result<Rectangle, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeBackgroundColor(to: newColor)
        notificationCenter.post(name: ViewController.planeDidChangeRectangleBackgroundColor, object: self, userInfo: [K.PlaneRectangle.changed: specifiedRectangle])
        return .success(specifiedRectangle)
    }

    public func changeAlphaValue(to newAlpha: Alpha) -> Result<Rectangle, PlaneError> {
        guard let specifiedRectangle = self.specifiedRectangle else {
            return .failure(.noSpecifiedRectangleToChangeError)
        }
        specifiedRectangle.changeAlphaValue(to: newAlpha)
        notificationCenter.post(name: ViewController.planeDidChangeRectangleAlpha, object: self, userInfo: [K.PlaneRectangle.changed: specifiedRectangle])
        return .success(specifiedRectangle)
    }

}

enum PlaneError: Error {
    case cannotSpecifyRectangleError
    case noSpecifiedRectangleToChangeError
}

extension Notification.Name {
    static let planeDidAddRectangle = Notification.Name("PlaneDidAddRectangle")
    static let planeDidSpecifyRectangle = Notification.Name("PlaneDidSpecifyRectangle")
    static let planeDidChangeRectangleBackgroundColor = Notification.Name("PlaneDidChangeRectangleBackgroundColor")
    static let planeDidChangeRectangleAlpha = Notification.Name("PlaneDidChangeRectangleAlpha")
}
