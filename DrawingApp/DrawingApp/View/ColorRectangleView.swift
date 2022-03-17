import Foundation
import UIKit

class ColorRectangleView: AbstractRectangleView{
    
    required init(rectangle: RectangleApplicable){
        super.init(rectangle: rectangle)
        if let rectangle = rectangle as? ColorRectangle{
            self.backgroundColor = UIColor(red: rectangle.backgroundColor.r,
                                           green: rectangle.backgroundColor.g,
                                           blue: rectangle.backgroundColor.b,
                                           alpha: CGFloat(rectangle.alpha.opacity.rawValue))
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
