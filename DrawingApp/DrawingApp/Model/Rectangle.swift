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
    
    func updateSize(width: Double, height: Double) {
        self.size.width = adjustRange(width)
        self.size.height = adjustRange(height)
        
        func adjustRange(_ value: Double)->Double{
            if(value<=0){
                return Double(1)
            }
            return value
        }
    }
    
    func isPointInsideTheRectangleRange(x: Double, y: Double) -> Bool {
        let minX = self.point.x
        let minY = self.point.y
        let maxX = minX + self.size.width
        let maxY = minY + self.size.height
        if((x <= maxX && x >= minX) && (y <= maxY && y >= minY)){
            return true
        }
        
        return false
    }
}

extension Rectangle: Hashable{
    
    var hashValue: Int{
        return self.id.hashValue
    }
    
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
}
