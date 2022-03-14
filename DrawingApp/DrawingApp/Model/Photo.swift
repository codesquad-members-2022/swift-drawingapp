//
//  Photo.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/14.
//

import Foundation

class Photo: Rectangularable {
    private let id: ID
    private(set) var size: Size
    private(set) var point: Point
    private(set) var backgroundColor: BackgroundColor
    private(set) var alpha: Alpha
    private(set) var image: Data
    
    func isPointInArea(_ point: Point) -> Bool {
        return point.x >= self.point.x && point.x <= self.point.x + self.size.width &&
        point.y >= self.point.y && self.point.y <= self.point.y + self.size.height
    }
    
    func changeBackgroundColor(to newColor: BackgroundColor) {
        self.backgroundColor = newColor
    }
    
    func changeAlphaValue(to newAlpha: Alpha) {
        self.alpha = newAlpha
    }
    
    init(id: ID, size: Size, point: Point, image: Data, alpha: Alpha) {
        self.id = id
        self.size = size
        self.point = point
        self.alpha = alpha
        self.image = image
        self.backgroundColor = BackgroundColor.init(r: 0, g: 0, b: 0)
    }
}

extension Photo: CustomStringConvertible {
    var description: String {
        return id.description
    }
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Photo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
