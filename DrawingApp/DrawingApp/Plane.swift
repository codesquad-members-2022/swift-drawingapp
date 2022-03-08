//
//  Plane.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/08.
//

import Foundation

protocol PlaneDelegate: AnyObject {
    func didCreate(rect: Rectangle)
    func didSelected(rect: Rectangle?)
}


// MARK:- Plane
class Plane {
    weak var delegate: PlaneDelegate?
    private var rectangles: [Rectangle] = []
    
    func createRect(in areaSize: Size) {
        let newRect = RectangleFactory.make(in: areaSize)
        self.rectangles.append(newRect)
        self.delegate?.didCreate(rect: newRect)
    }
    
    func countRect() -> Int {
        return rectangles.count
    }
    
    func selectRect(inside point: Point) {
        var selectedRect: Rectangle?
        // TODO: 위에 있는 Rect 가 가장 나중에 추가됨 => for문 거꾸로 돌아야 함
        for rect in rectangles {
            if rect.contain(inside: point) {
                selectedRect = rect
                break
            }
        }
        self.delegate?.didSelected(rect: selectedRect)
    }
}
