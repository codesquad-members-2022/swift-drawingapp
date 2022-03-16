//
//  Shapable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

protocol Shapable: CustomStringConvertible, AnyObject {
    var id: String { get }
    var size: Size { get }
    var alpha: Alpha { get }
    var origin: Point { get }
    var backgroundColor: Color { get }
    
    func contains(point: Point) -> Bool
    func setBackgroundColor(_ color: Color)
    func setAlpha(_ alpha: Alpha)
}

extension Shapable {
    func contains(point: Point) -> Bool {
        let maxX = self.origin.x + self.size.width
        let maxY = self.origin.y + self.size.height
        
        return self.origin <= point && point < Point(x: maxX, y: maxY)
    }
}
