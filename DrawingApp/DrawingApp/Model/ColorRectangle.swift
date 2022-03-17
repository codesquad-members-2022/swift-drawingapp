import Foundation

struct Color:Equatable, CustomStringConvertible{
    var r: Double = 0
    var g: Double = 0
    var b: Double = 0
    var description: String{
        return "r:\(Int(r*255)),g:\(Int(g*255)),b:\(Int(b*255))"
    }

    init(r: Double, g: Double, b: Double){
        self.r = adjustRange(value: r)/255
        self.g = adjustRange(value: g)/255
        self.b = adjustRange(value: b)/255
    }
    
    private func adjustRange(value: Double)-> Double{
        if(value<0){
            return Double(0)
        }else if(value>255){
            return Double(255)
        }else{
            return value
        }
    }
}

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
