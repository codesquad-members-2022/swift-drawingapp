//
//  Plane.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

import UIKit

struct Plane {
    
    var rectangles:[Rectangle] = []
    var selectedRectangle:Rectangle?
    
    var count:Int {
        self.rectangles.count
    }
}
