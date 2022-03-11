import Foundation

class Rectangle: CustomStringConvertible{
    
    struct Id:CustomStringConvertible, Hashable{
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
    
    struct Alpha: CustomStringConvertible{
        enum Opacity:Float, CaseIterable{
            
            case one = 0.1
            case two = 0.2
            case three = 0.3
            case four = 0.4
            case five = 0.5
            case six = 0.6
            case seven = 0.7
            case eight = 0.8
            case nine = 0.9
            case ten = 1.0

        }
        
        var opacity: Opacity = .ten
        var description: String{
            return "Alpha:\(String(self.opacity.rawValue))"
        }
        
        init(opacity: Int){
            self.opacity = Opacity.allCases[adjustRange(value: opacity)]
        }
        
        private func adjustRange(value: Int)->Int{
            if(value<0){
                return 0
            }else if(value >= Opacity.allCases.count){
                return Opacity.allCases.count - 1
            }else{
                return value
            }
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
