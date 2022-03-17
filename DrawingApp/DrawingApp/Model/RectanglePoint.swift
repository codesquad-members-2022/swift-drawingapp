import Foundation

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
