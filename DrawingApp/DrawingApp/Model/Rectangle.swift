import Foundation

class Rectangle: RectangleApplicable, CustomStringConvertible{
    
    private (set) var id: Id
    private (set) var size: Size
    private (set) var point: Point
    private (set) var alpha: Alpha
    var description: String{
        return "(\(id)), \(size), \(point), \(alpha)"
    }
    
    init(id: Id, size: Size, point: Point, alpha: Alpha){
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
