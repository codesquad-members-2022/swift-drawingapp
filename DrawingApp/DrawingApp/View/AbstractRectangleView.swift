import Foundation
import UIKit

class AbstractRectangleView: UIView{
    
    required init(rectangle: RectangleApplicable){
        super.init(frame: CGRect(x: rectangle.point.x,
                                y: rectangle.point.y,
                                width: rectangle.size.width,
                                height: rectangle.size.height))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
