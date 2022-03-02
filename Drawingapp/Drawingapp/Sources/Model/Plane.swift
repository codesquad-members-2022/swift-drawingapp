//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Plane {
    
    struct Action {
        var onScreenTapped: (Point) -> Void = { _ in }
        var makeSquareButtonTapped: () -> Void = { }
        var changeColorButtonTapped: () -> Void = { }
        var changeAlphaSliderEvent: (Float) -> Void = { _ in }
    }
    
    struct State {
        var didDisSelectedSquare: (Square?) -> Void = { _ in }
        var didSelectedSquare: (Square?) -> Void = { _ in }
        var drawSquare: (Square) -> Void = { _ in }
        var updateSquare: (Square) -> Void = { _ in }
    }
    
    var action = Action()
    var state = State()
    
    private let squareFactory = DrawingModelFactory()
    private let squares = Squares()
    
    init() {
        self.action.onScreenTapped = { point in
            let prevSelectedSquare = self.squares.selectedSquare
            let square = self.squares.selected(point: point)
            self.state.didDisSelectedSquare(prevSelectedSquare)
            self.state.didSelectedSquare(square)
        }
        
        self.action.makeSquareButtonTapped = {
            let square = self.squareFactory.make(type: .square)
            self.squares.append(square: square)
            self.state.drawSquare(square)
        }
        
        self.action.changeColorButtonTapped = {
            guard let square = self.squares.selectedSquare else {
                return
            }
            square.changeRandomColor()
            self.state.updateSquare(square)
        }
        
        self.action.changeAlphaSliderEvent = { alpha in
            guard let square = self.squares.selectedSquare else {
                return
            }
            square.update(alphaValue: alpha)
            self.state.updateSquare(square)
        }
    }
}
