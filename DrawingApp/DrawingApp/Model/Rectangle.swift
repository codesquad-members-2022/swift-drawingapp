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
        var r: Double = 0
        var g: Double = 0
        var b: Double = 0
        var description: String{
            return "r:\(Int(r)),g:\(Int(g)),b:\(Int(b))"
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
        
        var opacity: Int{
            return self.rawValue
        }
    }
    
    var id: Id
    var size: Size
    var point: Point
    var backgroundColor: Color
    var alpha: Alpha
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
