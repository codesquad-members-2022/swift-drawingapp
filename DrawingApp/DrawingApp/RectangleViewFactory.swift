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
            view.backgroundColor = UIColor(red: color.red/255, green: color.green/255, blue: color.blue/255, alpha: alpha.transparency/10)
            return view
        }
        return rectangleView
    }
}
