import Foundation

class SquareFactory {
    let idElement: String = "abcdefghijklmnopqrstuvwxyz0123456789"

    func createSquare(size: Size, point: Point, R: UInt8, G: UInt8, B: UInt8, alpha: Int) -> Square {
        return Square(id: getRandomId(), size: size, point: point, R: UInt8(R), G: UInt8(G), B: UInt8(B), alpha: alpha)
    }
    
    func createRandomSquare(frameWidth: Double, frameHeight: Double) -> Square {
        var width, height, x, y: Double
        repeat {
            width = Double(Int.random(in: 1..<Int(frameWidth)))
            height = Double(Int.random(in: 1..<Int(frameHeight)))
            x = Double(Int.random(in: 0..<Int(frameWidth)))
            y = Double(Int.random(in: 0..<Int(frameHeight)))
        } while !((x + width < frameWidth) && (y + height < frameHeight))

        return createSquare(size: Size(width: width, height: height), point: Point(X: x, Y: y), R: UInt8(Int.random(in: 0..<255)), G: UInt8(Int.random(in: 0..<255)), B: UInt8(Int.random(in: 0..<255)), alpha: 10)
    }
    
    func getRandomId() -> String {
        var id = String((0 ..< 9).map{ _ in idElement.randomElement()! })
        id.insert("-", at: id.index(id.startIndex, offsetBy: 3))
        id.insert("-", at: id.index(id.startIndex, offsetBy: 7))
        return id
    }
}
