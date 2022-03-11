//
//  AttributeValue.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/09.
//

import Foundation

protocol RectValue: Hashable{
    var size: MySize { get }
    var point: MyPoint { get }
    var alpha: Alpha { get }
    
    static func == (lhs: Self, rhs: Self) -> Bool
    
    func hash(into hasher: inout Hasher)
    
    func changeAlpha(alpha: Alpha)
    
    func findLocationRange(xPoint: Double, yPoint: Double) -> Bool
}
