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
        let userInfo: [AnyHashable : Any] = [ParamKey.point:self.origin]
        NotificationCenter.default.post(name: NotifiName.updatePoint, object: self, userInfo: userInfo)
    }
    
    func update(size: Size) {
        self.size = size
        let userInfo: [AnyHashable : Any] = [ParamKey.size:self.size]
        NotificationCenter.default.post(name: NotifiName.updateSize, object: self, userInfo: userInfo)
    }
}

extension DrawingModel {
    enum NotifiName {
        static let updateColor = NSNotification.Name("updateColor")
        static let updatePoint = NSNotification.Name("updatePoint")
        static let updateSize = NSNotification.Name("updateSize")
        static let updateAlpha = NSNotification.Name("updateAlpha")
        static let updateImageUrl = NSNotification.Name("updateImageUrl")
    }
    
    enum ParamKey {
        static let id = "id"
        static let color = "color"
        static let alpha = "alpha"
        static let imageUrl = "imageUrl"
        static let point = "point"
        static let size = "size"
    }
}
