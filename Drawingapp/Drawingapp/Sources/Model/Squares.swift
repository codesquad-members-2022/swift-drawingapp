//
//  Squares.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Squares {
    private var squares: [Square] = []
    
    var count: Int {
        squares.count
    }
    
    func append(square: Square) {
        self.squares.append(square)
    }
    
    func selected(point: Point) -> Square? {
        squares.filter{ $0.isSelected(by: point) }.first
    }
}

extension Squares {
    subscript(index: Int) -> Square? {
        if index >= 0 && index <= squares.count {
            return squares[index]
        }
        return nil
    }
}
