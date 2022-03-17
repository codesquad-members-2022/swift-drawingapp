import Foundation

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
