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

class Rectangle: Shapable, Hashable {
    // MARK: - Properties
    private(set) var backgroundColor: Color {
        didSet {
            self.notifyDidUpdated(key: .color, data: self.backgroundColor)
        }
    }
    
    private(set) var alpha: Alpha {
        didSet {
            self.notifyDidUpdated(key: .alpha, data: self.alpha)
        }
    }
    
    let id: String
    let size: Size
    let origin: Point
    
    var diagonalPoint: Point {
        return Point(x: self.origin.x + self.size.width, y: self.origin.y + self.size.height)
    }
    
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
        return self.origin <= point && point < Point(x: maxX, y: maxY)
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

// MARK: - CustomStringConvertible Protocol
extension Rectangle {
    var description: String {
        return """
        (\(self.id)), \(self.origin), \(self.size), \(self.backgroundColor), \(self.alpha)
        """
    }
}

// MARK: - Notification To Observer
extension Rectangle {
    enum NotificationKey {
        case alpha
        case color
    }
    
    func notifyDidCreated() {
        NotificationCenter.default.post(name: .RectangleDataDidCreated, object: self)
    }
    
    func notifyDidUpdated(key: NotificationKey, data: Any) {
        NotificationCenter.default.post(name: .RectangleDataDidUpdated, object: self, userInfo: [key: data])
    }
}
