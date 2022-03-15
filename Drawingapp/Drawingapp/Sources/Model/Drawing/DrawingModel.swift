//
//  DrawingModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

protocol Drawingable {
    var origin: Point { get }
    var size: Size { get }
    var alpha: Alpha { get }
    
    func update(alpha: Alpha)
    func update(origin: Point)
    func update(x: Double, y: Double)
    func update(width: Double, height: Double)
}

protocol Colorable: Drawingable {
    var color: Color { get }
    func update(color: Color)
}

protocol Imageable: Drawingable {
    var imageUrl: URL? { get }
    func update(imageUrl: URL?)
}

protocol Textable: Drawingable {
    var font: Font { get }
    var text: String { get }
    func update(fontName: String)
}

protocol Viewable {
    var displayName: String { get }
    var iconName: String { get }
}

class DrawingModel: Drawingable, CustomStringConvertible, Equatable, Hashable {
    let id: String
    let index: Int
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
        
    init(id: String, index: Int, origin: Point, size: Size, alpha: Alpha) {
        self.id = id
        self.index = index
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
    }
    
    func update(origin: Point) {
        self.origin = origin
    }
    
    func update(x: Double, y: Double) {
        let originX = origin.x + x < 1 ? 1 : origin.x + x
        let originY = origin.y + y < 1 ? 1 : origin.y + y
        update(origin: Point(x: originX, y: originY))
    }
    
    func update(width: Double, height: Double) {
        let sizeIncrease = Size(width: size.width + width, height: size.height + height)
        self.size = sizeIncrease
    }
}
