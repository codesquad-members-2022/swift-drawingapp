//
//  Plane.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/08.
//

import Foundation


class Plane {
    private var rectangles: [Rectangle] = [] {
        didSet {
            self.completion?()
        }
    }
    
    var completion: (() -> Void)?
    
    func createRect() {
        let newRect = RectangleFactory.make(size: Size(width: 150, height: 120))
        self.rectangles.append(newRect)
    }
    
    func countRect() -> Int {
        return rectangles.count
    }
}
