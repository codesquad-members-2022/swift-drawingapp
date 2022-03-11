import Foundation
import UIKit

class RectangleViewFactory{
    
    static func createRectangleView(rectangle: Rectangle)-> RectangleView{
        let rectangleView = RectangleView(frame: CGRect(x: rectangle.point.x,
                                                 y: rectangle.point.y,
                                                 width: rectangle.size.width,
                                                 height: rectangle.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangle.backgroundColor.r,
                                                green: rectangle.backgroundColor.g,
                                                blue: rectangle.backgroundColor.b,
                                                alpha: CGFloat(rectangle.alpha.opacity.rawValue))
        return rectangleView
    }
}
