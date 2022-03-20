//
//  PropertyUsecase.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import Foundation
import CoreGraphics

struct PropertyUsecase {
    private var plane : TouchablePlane
    
    init(touchable: TouchablePlane) {
        self.plane = touchable
    }
    
    func tapped(at point: CGPoint) -> BaseRect? {
        if let selected = plane.select(at: point) {
            return selected
        }
        else {
            plane.deselect()
            return nil
        }
    }

    func changeColor(with value: CGColor) {
        plane.changeColor(of: value)
    }
    
    func changeAlpha(with value: Rectangle.AlphaStep) {
        plane.changeAlpha(to: value)
    }
}
