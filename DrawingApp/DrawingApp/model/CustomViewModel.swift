//
//  CustomViewEntity.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/15.
//

import Foundation

class CustomViewModel{
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
}

extension CustomViewModel: Hashable, Equatable{
    static func == (lhs: CustomViewModel, rhs: CustomViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension CustomViewModel: CustomViewModelMutable{
    func getAlpha() -> Double {
        return alpha
    }
    
    func isPointInArea(point: ViewPoint) -> Bool{
        return self.point.x <= point.x && self.point.x + size.width >= point.x
        && self.point.y <= point.y && self.point.y + size.height >= point.y
    }
    
    func changeAlphaValue(alpha: Double){
        self.alpha = alpha
    }
    
    func getSize() -> ViewSize{
        return size
    }
    
    func getPoint() -> ViewPoint{
        return point
    }
}

protocol CustomViewModelMutable{
    func getAlpha() -> Double
    func isPointInArea(point: ViewPoint) -> Bool
    func changeAlphaValue(alpha: Double)
    func getSize() -> ViewSize
    func getPoint() -> ViewPoint
}
