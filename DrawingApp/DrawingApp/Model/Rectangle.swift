import Foundation

class Rectangle: RectangleApplicable, CustomStringConvertible{
    
    var id: Id
    var size: Size
    var point: Point
    var alpha: Alpha
    var description: String{
        return "(\(id)), \(size), \(point), \(alpha)"
    }
    
    init(id: Id, size: Size, point: Point, alpha: Alpha){
        self.id = id
        self.size = size
        self.point = point
        self.alpha = alpha
    }
    
}
