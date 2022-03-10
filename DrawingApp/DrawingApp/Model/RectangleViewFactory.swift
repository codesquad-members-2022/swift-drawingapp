//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/03/10.
//

import Foundation
import UIKit

struct RectangleViewFactory {

    static func makeView(of rectangle : Rectangle) -> RectangleView {
        let size = rectangle.size
        let position = rectangle.position
        let color = rectangle.backGroundColor
        let alpha = rectangle.alpha
        let rectangleFrame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        return RectangleView(from: rectangleFrame, color: color, alpha: alpha)
    }
    
    
}
