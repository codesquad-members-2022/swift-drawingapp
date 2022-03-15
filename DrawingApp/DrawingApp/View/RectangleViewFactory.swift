import Foundation
import UIKit

class RectangleViewFactory{
    
    static func createImageRectangleView(rectangle: ImageRectangle)-> ImageRectangleView{
        let rectangleView = ImageRectangleView(frame: CGRect(x: rectangle.point.x,
                                                              y: rectangle.point.y,
                                                              width: rectangle.size.width,
                                                              height: rectangle.size.height))
                                        
        rectangleView.image = UIImage(data: rectangle.backgroundImage)
        return rectangleView
    }
    
    static func createColorRectangleView(rectangle: ColorRectangle)-> ColorRectangleView{
        let rectangleView = ColorRectangleView(frame: CGRect(x: rectangle.point.x,
                                                 y: rectangle.point.y,
                                                 width: rectangle.size.width,
                                                 height: rectangle.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangle.backgroundColor.r,
                                                green: rectangle.backgroundColor.g,
                                                blue: rectangle.backgroundColor.b,
                                                alpha: CGFloat(rectangle.alpha.opacity.rawValue))
        return rectangleView
    }
    
    static func copyRectangleView(rectangle: Rectangle)-> UIView?{
        if(rectangle is ColorRectangle){
            return self.createColorRectangleView(rectangle: rectangle as! ColorRectangle)
        }else if(rectangle is ImageRectangle){
            return self.createImageRectangleView(rectangle: rectangle as! ImageRectangle)
        }
        return nil
    }
}
