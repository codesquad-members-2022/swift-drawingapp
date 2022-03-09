//
//  CGPoint+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/09.
//

import UIKit

protocol PointBuildable {
    init(x: Double, y: Double)
}

extension CGPoint {
    init(with point: Point) {
        self.init(x: point.x, y: point.y)
    }
    
    func convert<T: PointBuildable>(using Convertor: T.Type) -> T {
        return Convertor.init(x: self.x, y: self.y)
    }
}
