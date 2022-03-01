//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import Foundation
import OSLog

class Rectangle: Shapable {
    private(set) var id: String
    private(set) var size: Size
    private(set) var point: Point
    private(set) var backGroundColor: Color
    
    init(identifier: String,
         size: Size = Size(width: 150, height: 120),
         point: Point,
         backGroundColor: Color)
    {
        self.id = identifier
        self.size = size
        self.point = point
        self.backGroundColor = backGroundColor
        
        os_log(.debug, log: .default, "\n\(self)")
    }
}
