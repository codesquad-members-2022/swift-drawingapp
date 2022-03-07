//
//  Shape.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

protocol Shape {
    var id: String { get }
    var size: Size { get set }
    var point: Point { get set }
    var backgroundColor: BackgroundColor { get set }
    var alpha: Int { get set } // 1-10 사이값
    
    init(id: String, size: Size, point: Point, backgroundColor: BackgroundColor, alpha: Int)
}
