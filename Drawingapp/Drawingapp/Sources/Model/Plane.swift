//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

protocol PlaneInput {
    func touchPoint(where point: Point)
    func makeSquare()
    func colorChanged()
    func alphaChanged(alpha: Alpha?)
}

protocol PlaneOutput {
    func didDisSelectedSquare(to square: Square)
    func didSelectedSquare(to square: Square)
    func drawSquare(to square: Square)
    func update(to id: String, color: Color)
    func update(to id: String,point: Point)
    func update(to id: String,size: Size)
    func update(to id: String,alpha: Alpha)
}

class Plane: PlaneInput {
    private let squares = Squares()
    private var selectedSquare: Square?
    
    var delegate: PlaneOutput?
    
    func touchPoint(where point: Point) {
        if let selectSquare = self.selectedSquare {
            self.delegate?.didDisSelectedSquare(to: selectSquare)
        }
        
        if let selectSquare = self.squares.selected(point: point) {
            self.selectedSquare = selectSquare
            self.delegate?.didSelectedSquare(to: selectSquare)
        }
    }
    
    func makeSquare() {
        let square = DrawingModelFactory.makeSquare()
        self.squares.append(square: square)
        self.delegate?.drawSquare(to: square)
    }
    
    func colorChanged() {
        guard let square = self.selectedSquare else {
            return
        }
        square.update(color: ColorFactory.make())
        self.delegate?.update(to: square.id, color: square.color)
    }
    
    func alphaChanged(alpha: Alpha?) {
        guard let square = self.selectedSquare,
              let alpha = alpha else {
            return
        }
        square.update(alpha: alpha)
        self.delegate?.update(to: square.id, alpha: square.alpha)
        
    }
}
