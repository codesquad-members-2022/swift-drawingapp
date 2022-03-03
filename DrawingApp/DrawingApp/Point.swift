//
//  Position.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import Foundation

struct Point: CustomStringConvertible{
    
    private var x: Double
    private var y: Double
    
    init(x: Double, y: Double){
        self.x = x
        self.y = y
    }
    
    init(){
        let randomX = Double.random(in: 0...900.0)
        let randomY = Double.random(in: 0...650.0)
        self.init(x: randomX, y: randomY)
    }
    
    var description: String {
        return "X : \(x), Y: \(y)"
    }

}
