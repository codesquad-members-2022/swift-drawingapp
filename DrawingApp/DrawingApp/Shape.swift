//
//  Shape.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

protocol Shape {
    var id: String { get }
    var point: Point { get set }
    var size: Size { get set }
    var color: Color { get set }
    var alpha: Alpha { get set } // 1-10 사이값
    
    init(id: String, point: Point, size: Size, color: Color, alpha: Alpha)
}
