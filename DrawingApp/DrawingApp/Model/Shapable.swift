//
//  Shapable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

protocol Shapable: AnyObject {
    var id: String { get }
    var size: Size { get }
    var origin: Point { get }
    var diagonalPoint: Point { get }

    func contains(point: Point) -> Bool
}

extension Shapable {
    func contains(point: Point) -> Bool {
        let maxX = self.origin.x + self.size.width
        let maxY = self.origin.y + self.size.height
        
        return self.origin <= point && point < Point(x: maxX, y: maxY)
    }
    
    var diagonalPoint: Point {
        let maxX = self.origin.x + self.size.width
        let maxY = self.origin.y + self.size.height
        return Point(x: maxX, y: maxY)
    }
}
