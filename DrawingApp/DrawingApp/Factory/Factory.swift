//
//  RectangleFactory.swift.     
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation
import UIKit

class Factory {

    static func createRectangle() -> Rectangle {
        
        let DeviceWidth = UIScreen.main.bounds.size.width
        let DeviceHeight = UIScreen.main.bounds.size.height

        let size = Size(width: 150, height: 120)
        let point = Point(x: Double(Int.random(in: 0..<Int(DeviceWidth))),
                          y: Double(Int.random(in: 0..<Int(DeviceHeight))))
        let color = BackgroundColor(r: Int.random(in: 0...255),
                                    g: Int.random(in: 0...255),
                                    b: Int.random(in: 0...255))
        let alpha = Alpha.allCases[Int.random(in: 0..<10)]
        
        return Rectangle(id: ID.createId(), size: size, point: point, backGroundColor: color, alpha: alpha)
    }
    
}
