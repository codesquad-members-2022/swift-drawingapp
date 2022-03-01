import Foundation

class Rectangle: CustomStringConvertible{
    
    struct Size: Equatable, CustomStringConvertible{
        var width: Double
        var height: Double
        var description: String{
            return "W\(Int(width)),H\(Int(height))"
        }
        
        init(width: Double, height: Double){
            self.width = width
            self.height = height
        }
    }
    
    struct Point: Equatable, CustomStringConvertible{
        var x: Double
        var y: Double
        var description: String{
            return "x:\(Int(x)),y:\(Int(y))"
        }
        
        init(x: Double, y: Double){
            self.x = x
            self.y = y
        }
    }
    
    struct Color:Equatable, CustomStringConvertible{
        var r: Double
        var g: Double
        var b: Double
        var description: String{
            return "r:\(Int(r)),g:\(Int(g)),b:\(Int(b))"
        }
        
        init(r: Double, g: Double, b: Double){
            self.r = r
            self.g = g
            self.b = b
        }
    }
    
    enum Alpha:Int, CaseIterable, CustomStringConvertible{
        
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        case ten = 10
        
        var description: String{
            return "Alpha:\(String(self.rawValue))"
        }
    }
    
    private var id: String
    private var size: Size
    private var point: Point
    private var backgroundColor: Color
    private var alpha: Alpha
    var description: String{
        return "(\(id)), \(size), \(point), \(backgroundColor), \(alpha)"
    }
    
    init(id: String, size: Size, point: Point, backgroundColor: Color, alpha: Alpha){
        self.id = id
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
}
