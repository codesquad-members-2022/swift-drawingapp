//
//  AttributeValue.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/09.
//

import Foundation

class RectValue: Hashable{
    let id: String
    let madeTime = Date()
    private(set) var size: MySize
    private(set) var point: MyPoint
    private(set) var alpha: Alpha
    
    static func == (lhs: RectValue, rhs: RectValue) -> Bool {
        return lhs.id == rhs.id && lhs.madeTime == rhs.madeTime
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(madeTime)
    }
    
    func changePoint(point: MyPoint){
        self.point = point
    }
    
    func changeAlpha(alpha: Alpha){
        self.alpha = alpha
    }
    
    func findLocationRange(xPoint: Double, yPoint: Double) -> Bool{
        let minX: Double = self.point.x
        let maxX: Double = minX + self.size.width
        let minY: Double = self.point.y
        let maxY: Double = minY + self.size.height
        
        return xPoint >= minX && xPoint <= maxX && yPoint >= minY && yPoint <= maxY
    }
    
    init(id: String, size: MySize, point: MyPoint, alpha: Alpha){
        self.id = id
        self.size = size
        self.point = point
        self.alpha = alpha
    }
}
