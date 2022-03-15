//
//  CustomViewEntity.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/15.
//

import Foundation

class CustomViewEntity{
    private(set) var uniqueId: String
    private(set) var point: ViewPoint
    private(set) var size: ViewSize
    private(set) var alpha: Double
    
    init(uniqueId: String, point: ViewPoint, size: ViewSize, alpha: Double){
        self.uniqueId = uniqueId
        self.point = point
        self.size = size
        self.alpha = alpha
    }
    
    func changeAlphaValue(alpha: Double){
        self.alpha = alpha
    }
}
