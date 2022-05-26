import Foundation

class Square : CustomStringConvertible {
    private var id: String
    private var size: Size
    private var point: Point
    private var R: UInt8
    private var G: UInt8
    private var B: UInt8
    private var alpha: Int

    init(id: String, size: Size, point: Point, R: UInt8, G: UInt8, B: UInt8, alpha: Int) {
        self.id = id
        self.size = size
        self.point = point

        self.R = R
        self.G = G
        self.B = B
        switch alpha {
        case ...0 :
            self.alpha = 0
        case 10...:
            self.alpha = 10
        default:
            self.alpha = alpha
        }
    }
    
    func isPointIncluded(position: Point) -> Bool {
        let X1: Double = self.point.X
        let X2: Double = self.point.X + self.size.Width
        let Y1: Double = self.point.Y
        let Y2: Double = self.point.Y + self.size.Height
        if (X1 <= position.X && position.X <= X2) && (Y1 <= position.Y && position.Y <= Y2) {
            return true
        }
        return false
    }
    
    var description: String {
        return "(\(id)), X:\(point.X),Y:\(point.Y), W\(size.Width), H\(size.Height), R:\(R), G:\(G), B:\(B), alpha: \(alpha)"
    }
}
