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
            self.r = adjustRange(value: r)
            self.g = adjustRange(value: g)
            self.b = adjustRange(value: b)
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
        
        var opacity = 10
        var description: String{
            return "Alpha:\(String(self.opacity))"
        }
        
        init(opacity: Int){
            self.opacity = adjustRange(opacity: opacity)
        }
        
        private func adjustRange(opacity: Int)-> Int{
            if(opacity>10){
                return 10
            }else if(opacity<1){
                return 1
            }else{
                return opacity
            }
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
