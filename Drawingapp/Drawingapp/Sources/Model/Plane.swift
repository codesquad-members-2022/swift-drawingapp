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
        var changeAlphaSliderEvent: (Alpha?) -> Void = { _ in }
    }
    
    struct State {
        var didDisSelectedSquare: (Square?) -> Void = { _ in }
        var didSelectedSquare: (Square?) -> Void = { _ in }
        var drawSquare: (Square) -> Void = { _ in }
        var updateSquare: (Square) -> Void = { _ in }
    }
    
    var action = Action()
    var state = State()
    
    private let drawingModelFactory = DrawingModelFactory()
    private let colorFactory = ColorFactory()
    private let squares = Squares()
    private var selectedSquare: Square?
    
    init() {
        self.action.onScreenTapped = { point in
            self.state.didDisSelectedSquare(self.selectedSquare)
            self.selectedSquare = self.squares.selected(point: point)
            self.state.didSelectedSquare(self.selectedSquare)
        }
        
        self.action.makeSquareButtonTapped = {
            let square = self.drawingModelFactory.makeSquare()
            self.squares.append(square: square)
            self.state.drawSquare(square)
        }
        
        self.action.changeColorButtonTapped = {
            guard let square = self.selectedSquare else {
                return
            }
            square.update(color: self.colorFactory.make())
            self.state.updateSquare(square)
        }
        
        self.action.changeAlphaSliderEvent = { alpha in
            guard let square = self.selectedSquare,
                  let alpha = alpha else {
                return
            }
            square.update(alpha: alpha)
            self.state.updateSquare(square)
        }
    }
}
