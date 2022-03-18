//
//  ColoredRectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/01.
//

import Foundation

typealias BackgroundColorControllable = BackgroundAdaptable & AlphaAdaptable

class ColoredRectangle: Shape, BackgroundColorControllable, Notifiable {
    // MARK: - Properties
    private(set) var backgroundColor: Color {
        didSet {
            self.notifyDidUpdated(key: .updated, data: self.backgroundColor)
        }
    }
    
    private(set) var alpha: Alpha {
        didSet {
            self.notifyDidUpdated(key: .updated, data: self.alpha)
        }
    }
    
    // MARK: - Initialisers
    init(id: String, origin: Point, size: Size, color: Color = .white, alpha: Alpha = .opaque) {
        self.backgroundColor = color
        self.alpha = alpha
        super.init(id: id, origin: origin, size: size)
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, color: Color = .white, alpha: Alpha = .opaque) {
        let origin = Point(x: x, y: y)
        let size = Size(width: width, height: height)
        self.alpha = alpha
        self.backgroundColor = color
        super.init(id: id, origin: origin, size: size)
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
    
    func notifyDidCreated() {
        NotificationCenter.default.post(name: .RectangleModelDidCreated, object: self)
    }
    
    func notifyDidUpdated(key: NotificationKey, data: Any) {
        NotificationCenter.default.post(name: .RectangleModelDidUpdated, object: self, userInfo: [key: data])
    }
}

// MARK: - CustomStringConvertible Protocol
extension ColoredRectangle: CustomStringConvertible {
    var description: String {
        return """
        (\(self.id)), \(self.origin), \(self.size), \(self.backgroundColor), \(self.alpha)
        """
    }
}
