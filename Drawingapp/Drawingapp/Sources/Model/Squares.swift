//
//  Squares.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Squares {
    private var squares: [Square] = []
    
    private(set) var selectedSquare: Square?
    
    var count: Int {
        squares.count
    }
    
    func append(square: Square) {
        self.squares.append(square)
    }
    
    func selected(point: Point) -> Square? {
        selectedSquare = squares.filter{ $0.isSelected(by: point) }.last
        return selectedSquare
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
