//
//  DrawingModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

class DrawingModel: CustomStringConvertible, Equatable {
    
    let id: String
    let point: Point
    let size: Size
    public private(set) var color: Color?
    public private(set) var alpha: Alpha
    
    var description: String {
        "id: ( \(id) ), \(point), \(size), \(color), alpha: \(alpha)"
    }
    
    static func == (lhs: DrawingModel, rhs: DrawingModel) -> Bool {
        lhs.id == rhs.id
    }
        
    init(id: String, point: Point, size: Size, color: Color?, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
    
    func isSelected(by touchPoint: Point) -> Bool {
        if touchPoint.x >= point.x, touchPoint.y >= point.y,
           touchPoint.x <= point.x + size.width, touchPoint.y <= point.y + size.height {
            return true
        }
        return false
    }
    
    func update(color: Color) {
        self.color = color
        let userInfo: [AnyHashable : Any] = [ParamKey.color:color]
        NotificationCenter.default.post(name: NotifiName.updateColor, object: self, userInfo: userInfo)
    }
    
    func update(alpha: Alpha) {
        self.alpha = alpha
        let userInfo: [AnyHashable : Any] = [ParamKey.alpha:alpha]
        NotificationCenter.default.post(name: NotifiName.updateAlpha, object: self, userInfo: userInfo)
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
    }
}
