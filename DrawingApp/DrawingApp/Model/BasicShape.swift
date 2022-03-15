//
//  BasicShape.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/15.
//

import Foundation

class BasicShape {
    
    private(set) var id: Identifier
    private(set) var point: Point
    private(set) var size: Size
    
    init(identifier: Identifier, point: Point, size: Size = Size(width: 150, height: 120)) {
        self.id = identifier
        self.point = point
        self.size = size
    }
}

extension BasicShape: CustomStringConvertible {
    var description: String {
        return "(\(self.id), \(self.point), \(self.size)"
    }
}

extension BasicShape: Hashable {
    static func == (lhs: BasicShape, rhs: BasicShape) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
