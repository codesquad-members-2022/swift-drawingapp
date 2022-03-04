//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

protocol PlaneInput {
    func touchPoint(where point: Point)
    func makeRectangle()
    func colorChanged()
    func alphaChanged(alpha: Alpha)
}

protocol PlaneOutput {
    func didDisSelectedRectangle(to id: String)
    func didSelectedRectangle(to rectangle: Rectangle)
    func draw(to rectangle: Rectangle)
    func update(to id: String, color: Color)
    func update(to id: String, point: Point)
    func update(to id: String, size: Size)
    func update(to id: String, alpha: Alpha)
}

class Plane {
    var delegate: PlaneOutput?
    
    private var rectangles: [Rectangle] = []
    private var selectedRectangle: Rectangle?
    
    var count: Int {
        rectangles.count
    }
    
    subscript(index: Int) -> Rectangle? {
        if index >= 0 && index <= rectangles.count {
            return rectangles[index]
        }
        return nil
    }
    
    private func selected(point: Point) -> Rectangle? {
        rectangles.filter{ $0.isSelected(by: point) }.last
    }
}

extension Plane: PlaneInput {
    func touchPoint(where point: Point) {
        if let selectedRectangle = self.selectedRectangle {
            self.delegate?.didDisSelectedRectangle(to: selectedRectangle.id)
            self.selectedRectangle = nil
        }
        
        if let selectedRectangle = self.selected(point: point) {
            self.selectedRectangle = selectedRectangle
            self.delegate?.didSelectedRectangle(to: selectedRectangle)
        }
    }
    
    func makeRectangle() {
        let rectangle = DrawingModelFactory.makeRectangle()
        self.rectangles.append(rectangle)
        self.delegate?.draw(to: rectangle)
    }
    
    func colorChanged() {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(color: ColorFactory.make())
        self.delegate?.update(to: rectangle.id, color: rectangle.color)
    }
    
    func alphaChanged(alpha: Alpha) {
        guard let rectangle = self.selectedRectangle else {
            return
        }
        rectangle.update(alpha: alpha)
        self.delegate?.update(to: rectangle.id, alpha: rectangle.alpha)
    }
    
}
