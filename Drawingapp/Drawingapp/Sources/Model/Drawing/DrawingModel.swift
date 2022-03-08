//
//  DrawingModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

//protocol DrawingProperty: Hashable {
//    var id: String { get }
//    var point: Point { get }
//    var size: Size { get }
//    var alpha: Alpha { get }
//}

protocol Colorable {
    func update(color: Color)
}

protocol Imageable {
    func update(imageUrl: URL?)
}

class DrawingModel: CustomStringConvertible, Equatable, Hashable {
    let id: String
    let point: Point
    let size: Size
    public private(set) var alpha: Alpha
    
    var hashValue: Int {
        id.hashValue
    }
    
    var description: String {
        "id: ( \(id) ), \(point), \(size), alpha: \(alpha)"
    }
    
    static func == (lhs: DrawingModel, rhs: DrawingModel) -> Bool {
        lhs.id == rhs.id
    }
        
    init(id: String, point: Point, size: Size, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.alpha = alpha
    }
    
    func isSelected(by touchPoint: Point) -> Bool {
        if touchPoint.x >= point.x, touchPoint.y >= point.y,
           touchPoint.x <= point.x + size.width, touchPoint.y <= point.y + size.height {
            return true
        }
        return false
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
