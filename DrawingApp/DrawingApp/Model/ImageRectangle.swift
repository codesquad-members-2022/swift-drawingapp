import Foundation

class ImageRectangle: RectangleApplicable, CustomImageApplicable, CustomStringConvertible{
    
    private (set) var id: Id
    private (set) var size: Size
    private (set) var point: Point
    private (set) var alpha: Alpha
    private (set) var backgroundImage: Data
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
    
    func updateAlpha(opacity: Int) {
        self.alpha = Alpha(opacity: opacity)
    }
    
    func updatePoint(x: Double, y: Double) {
        self.point.x = x
        self.point.y = y
    }
     
}
