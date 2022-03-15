//
//  Plane.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/04.
//

import Foundation

class Plane {
    
    var delegate: PlaneDelegate?
    private var shapes: [BasicShape] = []
    private(set) var selected: BasicShape?
    
    subscript(index: Int) -> BasicShape {
        return shapes[index]
    }
    
    var count: Int {
        return shapes.count
    }
    
    func addRectangle(bound: (x: Double, y: Double), by factoryType: RandomShapeFactory.Type) {
        let newRectangle = factoryType.createRandomRectangle(xBound: bound.x, yBound: bound.y)
        shapes.append(newRectangle)
        delegate?.didCreateShape(newRectangle)
    }
    
    func updateSelected(shape: BasicShape) {
        selected = shape
        delegate?.didChangeSelectedShape(shape)
    }
    
    func clearSelected() {
        selected = nil
    }
    
    private func isShapeExist(on coordinate: (x: Double, y: Double), target shape: BasicShape) -> Bool {
        let xBound = (shape.point.x)...(shape.point.x + shape.size.width)
        let yBound = (shape.point.y)...(shape.point.y + shape.size.height)
        
        if (xBound ~= coordinate.x) && (yBound ~= coordinate.y) {
            return true
        }
        
        return false
    }
    
    func searchTopShape(on coordinate: (x: Double, y: Double)) {
        for shape in shapes.reversed() {
            if isShapeExist(on: coordinate, target: shape) {
                delegate?.didSelectShape(shape)
                return
            }
        }
        
        delegate?.didSelectEmptyView()
    }
    
    func changeBackgroundColor() {
        guard let selectedShape = selected as? BasicShape & Colorable else { return }
        let randomColor = RandomAttributeFactory.generateRandomColor()
        selectedShape.changeBackgroundColor(by: randomColor)
        delegate?.didUpdateSelectedShapeBackgroundColor(selectedShape)
    }
    
    func upAlphaValue() {
        guard let selectedShape = selected as? BasicShape & Alphable else { return }
        selectedShape.upAlphaLevel()
        delegate?.didUpdateSelectedShapeAlpha(selectedShape)
    }
    
    func downAlphaValue() {
        guard let selectedShape = selected as? BasicShape & Alphable else { return }
        selectedShape.downAlphaLevel()
        delegate?.didUpdateSelectedShapeAlpha(selectedShape)
    }
}
