import Foundation
import UIKit

class RectangleViewFactory{

    private static let rectangleType: Dictionary<ObjectIdentifier, AbstractRectangleView.Type> = [
        ObjectIdentifier(ColorRectangle.self): ColorRectangleView.self,
        ObjectIdentifier(ImageRectangle.self): ImageRectangleView.self
    ]
    
    static func createRectangleView(rectangle: RectangleApplicable)-> AbstractRectangleView?{
        guard let rectangleView = self.rectangleType[ObjectIdentifier(type(of: rectangle))] else { return nil }
        return rectangleView.init(rectangle: rectangle)
    }
}

