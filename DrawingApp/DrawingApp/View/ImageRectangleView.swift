import Foundation
import UIKit

class ImageRectangleView: AbstractRectangleView{
    
    private var imageView: UIImageView = UIImageView()
    
    required init(rectangle: RectangleApplicable){
        super.init(rectangle: rectangle)
        if let rectangle = rectangle as? ImageRectangle{
            self.imageView.image = UIImage(data: rectangle.backgroundImage)
            self.imageView.frame = self.bounds
            self.addSubview(self.imageView)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
