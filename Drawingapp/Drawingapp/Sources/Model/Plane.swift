//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

protocol PlaneInput {
    func drawingBoardTapped(where point: Point)
    func makeSquareButtonTapped()
    func changeColorButtonTapped()
    func alphaChanged(alpha: Alpha?)
}

protocol PlaneOutput {
    func didDisSelectedSquare(to square: Square?)
    func didSelectedSquare(to square: Square?)
    func drawSquare(to square: Square)
    func updateSquare(to square: Square)
}

class Plane: PlaneInput {
    private let drawingModelFactory = DrawingModelFactory()
    private let colorFactory = ColorFactory()
    private let squares = Squares()
    private var selectedSquare: Square?
    
    var delegate: PlaneOutput?
    
    func drawingBoardTapped(where point: Point) {
        self.delegate?.didDisSelectedSquare(to: self.selectedSquare)
        self.selectedSquare = self.squares.selected(point: point)
        self.delegate?.didSelectedSquare(to: self.selectedSquare)
    }
    
    func makeSquareButtonTapped() {
        let square = self.drawingModelFactory.makeSquare()
        self.squares.append(square: square)
        self.delegate?.drawSquare(to: square)
    }
    
    func changeColorButtonTapped() {
        guard let square = self.selectedSquare else {
            return
        }
        square.update(color: self.colorFactory.make())
        self.delegate?.updateSquare(to: square)
    }
    
    func alphaChanged(alpha: Alpha?) {
        guard let square = self.selectedSquare,
              let alpha = alpha else {
            return
        }
        square.update(alpha: alpha)
        self.delegate?.updateSquare(to: square)
        
    }
}
