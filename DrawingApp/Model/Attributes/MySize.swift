//
//  Attributes.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

struct MySize{
    let width: Double
    let height: Double
    
    func widthValue() -> Double{
        return self.width
    }
    
    func heightValue() -> Double{
        return self.height
    }
    
    init(width: Double, height: Double){
        self.width = width
        self.height = height
    }
}
