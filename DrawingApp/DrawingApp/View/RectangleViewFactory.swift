//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by dale on 2022/03/07.
//

import Foundation
import UIKit

struct RectangleViewFactory {
    func makeNewRectangleView(rectangle: Rectangle) -> UIView {
        var rectangleView : UIView {
            let size = rectangle.size
            let position = rectangle.position
            let color = rectangle.backGroundColor
            let alpha = rectangle.alpha
            let view = UIView(frame: CGRect(x: position.x , y: position.y, width: size.width, height: size.height))
            view.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: alpha.transparency)
            return view
        }
        return rectangleView
    }
}
