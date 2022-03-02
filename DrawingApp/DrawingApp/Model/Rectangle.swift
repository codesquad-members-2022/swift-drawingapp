import Foundation

class Rectangle: CustomStringConvertible{
    
    struct Id:CustomStringConvertible{
        private var idValue: String
        var description: String{
            return self.idValue
        }
        
        init(){
            var asciiValues: [Int] = []
            asciiValues.append(contentsOf: Array(97...122))
            asciiValues.append(contentsOf: Array(48...57))
            
            var characters: [Character] = []
            while(characters.count != 9){
                guard let value = UnicodeScalar(asciiValues[Int.random(in: 0..<asciiValues.count)]) else { continue }
                let character = Character(value)
                characters.append(character)
            }
            self.idValue = "\(String(characters[0...2]))-\(String(characters[3...5]))-\(String(characters[6...8]))"
        }
    }
    
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
    
    private var id: Id
    private var size: Size
    private var point: Point
    private var backgroundColor: Color
    private var alpha: Alpha
    var description: String{
        return "(\(id)), \(size), \(point), \(backgroundColor), \(alpha)"
    }
    
    init(id: Id, size: Size, point: Point, backgroundColor: Color, alpha: Alpha){
        self.id = id
        self.size = size
        self.point = point
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
}
