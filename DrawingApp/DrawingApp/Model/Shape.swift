//
//  Shape.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

protocol Shape {
    var id: String { get }
    
    func isContainPoint(_ point: Point) -> Bool
    
    func getSize() -> Size
    
    func getPoint() -> Point
    
    func getColor() -> Color
    
    func getAlpha() -> Alpha
}
