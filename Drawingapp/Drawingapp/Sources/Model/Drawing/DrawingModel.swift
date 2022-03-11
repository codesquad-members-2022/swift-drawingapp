//
//  DrawingModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

protocol Colorable {
    func update(color: Color)
}

protocol Imageable {
    func update(imageUrl: URL?)
}

protocol Textable {
    func update(text: String)
    func update(font: Font)
    func update(fontColor: Color)
}

class DrawingModel: CustomStringConvertible, Equatable, Hashable {
    let id: String
    public private(set) var size: Size
    public private(set) var origin: Point
    public private(set) var alpha: Alpha
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var description: String {
        "id: ( \(id) ), \(origin), \(size), alpha: \(alpha)"
    }
    
    static func == (lhs: DrawingModel, rhs: DrawingModel) -> Bool {
        lhs.id == rhs.id
    }
        
    init(id: String, origin: Point, size: Size, alpha: Alpha) {
        self.id = id
        self.origin = origin
        self.size = size
        self.alpha = alpha
    }
    
    func isSelected(by touchPoint: Point) -> Bool {
        if touchPoint.x >= origin.x, touchPoint.y >= origin.y,
           touchPoint.x <= origin.x + size.width, touchPoint.y <= origin.y + size.height {
            return true
        }
        return false
    }
    
    func update(alpha: Alpha) {
        self.alpha = alpha
        let userInfo: [AnyHashable : Any] = [ParamKey.alpha:alpha]
        NotificationCenter.default.post(name: NotifiName.updateAlpha, object: self, userInfo: userInfo)
    }
    
    func update(origin: Point) {
        self.origin = origin
        let userInfo: [AnyHashable : Any] = [ParamKey.origin:self.origin]
        NotificationCenter.default.post(name: NotifiName.updateOrigin, object: self, userInfo: userInfo)
    }
    
    func originMove(x: Double, y: Double) {
        let originX = origin.x + x < 1 ? 1 : origin.x + x
        let originY = origin.y + y < 1 ? 1 : origin.y + y
        let moveOrigin = Point(x: originX, y: originY)
        update(origin: moveOrigin)
    }
    
    func update(size: Size) {
        self.size = size
        let userInfo: [AnyHashable : Any] = [ParamKey.size:self.size]
        NotificationCenter.default.post(name: NotifiName.updateSize, object: self, userInfo: userInfo)
    }
    
    func sizeIncrease(width: Double, height: Double) {
        let sizeIncrease = Size(width: size.width + width, height: size.height + height)
        update(size: sizeIncrease)
    }
}

extension DrawingModel {
    enum NotifiName {
        static let updateColor = NSNotification.Name("updateColor")
        static let updateOrigin = NSNotification.Name("updateOrigin")
        static let updateSize = NSNotification.Name("updateSize")
        static let updateAlpha = NSNotification.Name("updateAlpha")
        static let updateImageUrl = NSNotification.Name("updateImageUrl")
        static let updateText = NSNotification.Name("updateText")
        static let updateFont = NSNotification.Name("updateFont")
        static let updateFontColor = NSNotification.Name("updateFontColor")
    }
    
    enum ParamKey {
        static let id = "id"
        static let alpha = "alpha"
        static let origin = "origin"
        static let size = "size"
        static let color = "color"
        static let imageUrl = "imageUrl"
        static let text = "text"
        static let font = "font"
        static let fontColor = "fontColor"
    }
}
