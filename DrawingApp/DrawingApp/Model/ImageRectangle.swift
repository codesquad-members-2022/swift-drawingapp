import Foundation

class ImageRectangle: RectangleApplicable, CustomImageApplicable, CustomStringConvertible{
    
    var id: Id
    var size: Size
    var point: Point
    var alpha: Alpha
    var backgroundImage: Data
    var description: String{
        return "(\(id)), \(size), \(point), \(backgroundImage.hashValue), \(alpha)"
    }
     
    init(id: Id, size: Size, point: Point, backgroundImage: Data, alpha: Alpha){
        self.backgroundImage = backgroundImage
        self.id = id
        self.size = size
        self.point = point
        self.alpha = alpha
    }
     
}
