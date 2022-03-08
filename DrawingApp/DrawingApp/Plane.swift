//
//  Plane.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/08.
//

import Foundation

protocol PlaneDelegate: AnyObject {
    func didCreate(rect: Rectangle)
}


// MARK:- Plane
class Plane {
    weak var delegate: PlaneDelegate?
    private var rectangles: [Rectangle] = []
    
    func createRect() {
        let newRect = RectangleFactory.make(size: Size(width: 150, height: 120))
        self.rectangles.append(newRect)
        self.delegate?.didCreate(rect: newRect)
    }
    
    func countRect() -> Int {
        return rectangles.count
    }
}
