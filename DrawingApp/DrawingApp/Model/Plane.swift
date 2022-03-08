//
//  Plane.swift
//  DrawingApp
//
//  Created by dale on 2022/03/03.
//

import Foundation
import UIKit

protocol PlaneDelegate {
    func didAddRectangle(rectangle: Rectangle)
    func didSearchRectangle(index: Int)
    func didUpdatedAlpha(alpha : Alpha)
    func didChangedColor(color : Color)
}

class Plane {
    var rectangles : [Rectangle] = []
    var delegate : PlaneDelegate?
    var selectedRectangle : Rectangle?
    
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
        delegate?.didAddRectangle(rectangle: rectangle)
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
            delegate?.didSearchRectangle(index: selectedIndex)
        }
    }
    
    func updateAlphaValue(with alpha: Alpha) {
        self.selectedRectangle?.alpha = alpha
        delegate?.didUpdatedAlpha(alpha: alpha)
    }
    
    func changeRandomColor() {
        var randomColor : Color? {
            var randomInt: Int {
                Color.colorRange.randomElement() ?? 0
            }
            let randomColor = Color(red: randomInt, green: randomInt, blue: randomInt)
            return randomColor
        }
        guard let randomColor = randomColor else {return}
        self.selectedRectangle?.backGroundColor = randomColor
        delegate?.didChangedColor(color: randomColor)
    }
}
