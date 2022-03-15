import Foundation

struct Rectangle: CustomStringConvertible {
    enum Alpha: Int {
        case one = 1
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        
        
        static func random() -> Self  {
            let randomInt = Int.random(in: 1...10)
            var alpha: Alpha = .one
            switch randomInt{
            case 1:
                alpha = .one
            case 2:
                alpha = .two
            case 3:
                alpha = .three
            case 4:
                alpha = .four
            case 5:
                alpha = .five
            case 6:
                alpha = .six
            case 7:
                alpha = .seven
            case 8:
                alpha = .eight
            case 9:
                alpha = .nine
            default:
                alpha = .ten
            }
            return alpha
        }
        
        mutating func change(_ alpha: Int) {
            switch alpha {
            case 1:
                self = .one
            case 2:
                self = .two
            case 3:
                self = .three
            case 4:
                self = .four
            case 5:
                self = .five
            case 6:
                self = .six
            case 7:
                self = .seven
            case 8:
                self = .eight
            case 9:
                self = .nine
            default:
                self = .ten
            }
        }
    }
    
    struct BackgroundColor {
        var R: Int = 0
        var G: Int = 0
        var B: Int = 0
        
        init() {
            random()
        }
        
        mutating func random()  {
            let randomR: Int = Int.random(in: 0...255)
            let randomG: Int = Int.random(in: 0...255)
            let randomB: Int = Int.random(in: 0...255)
            self.R = randomR
            self.G = randomG
            self.B = randomB
        }
        
        func showRGBVlaue() -> String {
            let hexaR = String(format: "%02X", R)
            let hexaG = String(format: "%02X", G)
            let hexaB = String(format: "%02X", B)
            return "\(hexaR)\(hexaG)\(hexaB)"
        }
        
    }
    
    struct Size {
        let width: Double = 150.0
        let height: Double = 120.0
    }
    
    struct Bound {
        let rangeOfX: ClosedRange<Double>
        let rangeOfY: ClosedRange<Double>
    }
    
    struct Point {
        var x: Double = 0.0
        var y: Double = 0.0
        
        mutating func random() {
            let randomX: Double = Double.random(in: 20...738)
            let randomY: Double = Double.random(in: 24...680)
            self.x = randomX
            self.y = randomY
        }
        
        init() {
            random()
        }
        
        init(x: Double, y: Double) {
            self.x = x
            self.y = y
        }
    }

    var description: String {
        return "(\(self.id)), X:\(self.point.x), Y:\(self.point.y), W\(self.size.width), H\(self.size.height), R\(self.color.R), G\(self.color.G), B\(self.color.B), Alpha: \(self.alpha.rawValue)"
    }
    
    private let id: String
    private let point: Point
    private let size : Size
    private var color: BackgroundColor
    private var alpha: Alpha
    
    func getPoint() -> Point {
        return point
    }
    func getSize() -> Size {
        return size
    }
    func getColor() -> BackgroundColor {
        return color
    }
    func getAlpha() -> Alpha {
        return alpha
    }
    
    func rangeOfPoint() -> Bound {
        let boundOfX = point.x...(point.x + size.width)
        let boundOfY = point.y...(point.y + size.height)
        return Bound(rangeOfX: boundOfX, rangeOfY: boundOfY)
    }
    
    init(id: String, point: Point, size: Size, color : BackgroundColor, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
}

extension Rectangle: Hashable {
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension Rectangle {
    mutating func changeColor() -> Rectangle {
        self.color.random()
        return self
    }
    mutating func changeAlpha(_ alpha: Int) -> Rectangle {
        self.alpha.change(alpha)
        return self
    }
}
