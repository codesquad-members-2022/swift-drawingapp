//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

protocol RectangleBuildable {
    init(x: Double, y: Double, width: Double, height: Double)
}

class Rectangle: Shapable {
    // MARK: - Properties
    private(set) var backgroundColor: Color
    private(set) var alpha: Alpha
    
    let id: String
    let size: Size
    let origin: Point
    
    // MARK: - Initialisers
    init(id: String, origin: Point, size: Size, color: Color = .white, alpha: Alpha = .opaque) {
        self.id = id
        self.origin = origin
        self.size = size
        self.backgroundColor = color
        self.alpha = alpha
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, color: Color = .white, alpha: Alpha = .opaque) {
        self.id = id
        self.origin = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
        self.backgroundColor = color
        self.alpha = alpha
    }
    
    func contains(point: Point) -> Bool {
        let maxX = self.origin.x + self.size.width
        let maxY = self.origin.y + self.size.height
        return point >= self.origin && point <= Point(x: maxX, y: maxY)
    }
    
    func convert<T: RectangleBuildable>(using Convertor: T.Type) -> T {
        return Convertor.init(x: self.origin.x, y: self.origin.y, width: self.size.width, height: self.size.height)
    }
    
    func setBackgroundColor(_ color: Color) {
        self.backgroundColor = color
    }
    
    func setAlpha(_ alpha: Alpha) {
        self.alpha = alpha
    }
}

extension Rectangle: Hashable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs === rhs
    }
    
    var description: String {
        return """
        (\(self.id)), \(self.origin), \(self.size), \(self.backgroundColor), \(self.alpha)
        """
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

// MARK: - Notification To Observer
extension Rectangle {
    func postDidCreated() {
        NotificationCenter.default.post(name: .RectangleDataDidCreated, object: self)
    }
    
    func postDidUpdated(key: String, data: Any) {
        NotificationCenter.default.post(name: .RectangleDataDidUpdated, object: self, userInfo: [key: data])
    }
}
