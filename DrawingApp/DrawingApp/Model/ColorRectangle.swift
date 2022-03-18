import Foundation

class ColorRectangle: RectangleApplicable, RandomColorApplicable, CustomStringConvertible{
    
    private (set) var id: Id
    private (set) var size: Size
    private (set) var point: Point
    private (set) var alpha: Alpha
    private (set) var backgroundColor: Color
    var description: String{
        return "(\(id)), \(size), \(point), \(backgroundColor), \(alpha)"
    }
    
    init(id: Id, size: Size, point: Point, backgroundColor: Color, alpha: Alpha){
        self.backgroundColor = backgroundColor
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
    
    func updateBackgroundColor(newColor: Color){
        self.backgroundColor = newColor
    }
    
}
