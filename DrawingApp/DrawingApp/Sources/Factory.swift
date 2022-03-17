//
//  RectangleFactory.swift.     
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation
import UIKit

class Factory {

    static func createRectangle(marginX: Double, marginY: Double) -> Rectangle {

        let size = Size(width: 150, height: 120)
        let point = Point(x: round(Double.random(in: 0..<marginX)),
                          y: round(Double.random(in: 0..<marginY)))
        let color = Color(r: round(Double.random(in: 0...255)),
                          g: round(Double.random(in: 0...255)),
                          b: round(Double.random(in: 0...255)))
        let alpha = Alpha(value: Double(Int.random(in: 1...10)))
        
        return Rectangle(id: ID.createId(), size: size, point: point, color: color, alpha: alpha)
    }
    
}
