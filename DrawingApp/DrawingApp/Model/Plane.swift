//
//  Plane.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

import UIKit

struct Plane {
    
    var rectangleViews:[UIView] = []
    var rectangles:[Rectangle] = []
    var seletedRectangle:UIView = UIView()
    
    var count:Int {
        self.rectangleViews.count
    }
}
