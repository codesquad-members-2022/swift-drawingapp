//
//  AttributeValue.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/09.
//

import Foundation

class RectValue: Hashable{
    enum NotificationName{
        static let changeSize = Notification.Name("changeSize")
        static let changePoint = Notification.Name("changePoint")
        static let changeAlpha = Notification.Name("changeAlpha")
    }
    
    private let id: String
    private let madeTime = Date()
    private(set) var size: MySize
    private(set) var point: MyPoint
    private(set) var alpha: Alpha
    
    static func == (lhs: RectValue, rhs: RectValue) -> Bool {
        return lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(madeTime)
    }
    
    func showValueId() -> String{
        return id
    }
    
    func changeSize(size: MySize){
        self.size = size
        NotificationCenter.default.post(name: RectValue.NotificationName.changeSize, object: self)
    }
    
    func changePoint(point: MyPoint){
        self.point = point
        NotificationCenter.default.post(name: RectValue.NotificationName.changePoint, object: self)
    }
    
    func changeAlpha(alpha: Alpha){
        self.alpha = alpha
        NotificationCenter.default.post(name: RectValue.NotificationName.changeAlpha, object: self)
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
