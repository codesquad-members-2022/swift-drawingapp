//
//  Drawingable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Drawingable {
    var origin: Point { get }
    var size: Size { get }
    var alpha: Alpha { get }
    
    func update(alpha: Alpha)
    func update(origin: Point)
    func update(x: Double, y: Double)
    func update(width: Double, height: Double)
}
