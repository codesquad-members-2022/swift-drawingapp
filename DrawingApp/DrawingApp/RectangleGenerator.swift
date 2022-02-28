//
//  RectangleGenerator.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import Foundation

class RectangleGenerator {
    private var id : String
    private var width : Double
    private var height : Double
    private var position : (Int,Int)
    private var backGroundColor : (Int,Int,Int)
    private var alpha : Int
    
    init(id: String, width : Double, height: Double, position : (Int,Int), color : (Int,Int,Int), alpha : Int) {
        self.id = id
        self.width = width
        self.height = height
        self.position = position
        self.backGroundColor = color
        self.alpha = alpha
    }
    
}
