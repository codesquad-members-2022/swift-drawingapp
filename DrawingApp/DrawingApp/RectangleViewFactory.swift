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
            view.backgroundColor = UIColor(cgColor: CGColor(red: CGFloat(color.red/255), green: CGFloat(color.green/255), blue: CGFloat(color.blue/255), alpha: CGFloat(alpha.transparency/10)))
            return view
        }
        return rectangleView
    }
}
