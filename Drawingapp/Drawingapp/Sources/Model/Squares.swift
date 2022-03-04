//
//  Squares.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Squares {
    private var squares: [Rectangle] = []
    
    var count: Int {
        squares.count
    }
    
    func append(square: Rectangle) {
        self.squares.append(square)
    }
    
    func selected(point: Point) -> Rectangle? {
        squares.filter{ $0.isSelected(by: point) }.last
    }
}

extension Squares {
    subscript(index: Int) -> Rectangle? {
        if index >= 0 && index <= squares.count {
            return squares[index]
        }
        return nil
    }
}
