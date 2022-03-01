//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Plane {
    
    struct Action {
        var onScreenTouched: (Point) -> Void = { _ in }
        var makeSquareButtonTapped: () -> Void = { }
    }
    
    struct State {
        var selectedSquare: (Square?) -> Void = { _ in }
        var renderSquare: (Square) -> Void = { _ in }
    }
    
    var action = Action()
    var state = State()
    
    private let squareFactory = Factory()
    private let squares = Squares()
    
    init() {
        self.action.onScreenTouched = { point in
            let square = self.squares.selected(point: point)
            self.state.selectedSquare(square)
        }
        
        self.action.makeSquareButtonTapped = {
            let square = self.squareFactory.makeSquare()
            self.squares.append(square: square)
            self.state.renderSquare(square)
        }
    }
}
