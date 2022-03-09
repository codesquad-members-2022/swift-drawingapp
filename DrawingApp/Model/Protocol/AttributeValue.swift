//
//  AttributeValue.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/09.
//

import Foundation

protocol AttributeValue: Hashable, CustomStringConvertible{
    var description: String{ get }
    
    static func == (lhs: Self, rhs: Self) -> Bool
    
    func hash(into hasher: inout Hasher)
    
    func showAlpha() -> Alpha
    
    func changeAlpha(alpha: Alpha)
    
    func findLocationRange(xPoint: Double, yPoint: Double) -> Bool
}
