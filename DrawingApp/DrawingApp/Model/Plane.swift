//
//  Plane.swift
//  DrawingApp
//
//  Created by dale on 2022/03/03.
//

import Foundation
import UIKit

protocol PlaneDelegate {
    func plane(didAdd rectangle: Rectangle)
    func plane(didSearch rectangle: Rectangle, at index: Int)
    func plane(didUpdated alpha : Alpha)
    func plane(didChanged color : Color)
}

class Plane {
    private var rectangles : [Rectangle] = []
    private var selectedRectangle : Rectangle?
    var delegate : PlaneDelegate?
    
    subscript(index: Int) -> Rectangle? {
        if index < rectangleCount {
            let targetRectangle = rectangles[index]
            return targetRectangle
        }
        return nil
    }
    
    var rectangleCount : Int {
        return rectangles.count
    }
    
    func addRectangle(rectangle: Rectangle) {
        self.rectangles.append(rectangle)
        delegate?.plane(didAdd: rectangle)
    }
    
    func searchRectangle(at position : Position) {
        for rectangle in rectangles.reversed() {
            if (rectangle.position.x...(rectangle.position.x + rectangle.size.width)).contains(position.x) && (rectangle.position.y...(rectangle.position.y + rectangle.size.height)).contains(position.y) {
                self.selectedRectangle = rectangle
                break
            }
        }
        guard let target = selectedRectangle else {return}
        if let selectedIndex = rectangles.lastIndex(of: target) {
            delegate?.plane(didSearch: target, at: selectedIndex)
        }
    }
    
    func updateAlphaValue(with alpha: Alpha) {
        self.selectedRectangle?.alpha = alpha
        delegate?.plane(didUpdated: alpha)
    }
    
    func changeRandomColor() {
        let randomColor = RandomGenerator.generateColor()
        guard let randomColor = randomColor else {return}
        self.selectedRectangle?.backGroundColor = randomColor
        delegate?.plane(didChanged: randomColor)
    }
}
