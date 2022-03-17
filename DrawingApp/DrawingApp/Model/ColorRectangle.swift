import Foundation

class ColorRectangle: RectangleApplicable, RandomColorApplicable, CustomStringConvertible{
    
    var id: Id
    var size: Size
    var point: Point
    var alpha: Alpha
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
    
    func updateBackgroundColor(newColor: Color){
        self.backgroundColor = newColor
    }
    
}
