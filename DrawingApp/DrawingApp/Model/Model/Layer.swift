//
//  Layer.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/07.
//

import Foundation

class Layer {
    
    private(set) var id: ID
    private(set) var origin: Point
    private(set) var size: Size
    
    init(id: ID, origin: Point, size: Size) {
        self.id = id
        self.origin = origin
        self.size = size
    }
    
    var center: Point {
        Point(x: origin.x + (size.width / 2),
              y: origin.y + (size.height / 2))
    }
    
    var aspectRatio: Double {
        size.height / size.width
    }
    
    func contains(_ point: Point) -> Bool {
        return (origin.x...origin.x+size.width).contains(point.x)
        && (origin.y...origin.y+size.height).contains(point.y)
    }
    
    func set(to origin: Point) {
        self.origin = origin
    }
    
    func set(to size: Size) {
        self.size = size
    }
}

extension Layer: Hashable {
    static func == (lhs: Layer, rhs: Layer) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

protocol ColorMutable {
    var color: Color { get }
    func set(to color: Color)
}

protocol AlphaMutable {
    var alpha: Alpha { get }
    func set(to alpha: Alpha)
}

protocol TextMutable {
    var text: String { get }
    func set(to text: String)
}
