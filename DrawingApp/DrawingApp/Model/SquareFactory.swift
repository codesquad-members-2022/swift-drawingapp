import Foundation

class SquareFactory {
    let idElement: String = "abcdefghijklmnopqrstuvwxyz0123456789"

    func createSquare(size: Size, point: Point, R: UInt8, G: UInt8, B: UInt8, alpha: Int) -> Square {
        return Square(id: getRandomId(), size: size, point: point, R: UInt8(R), G: UInt8(G), B: UInt8(B), alpha: alpha)
    }
    
    func getRandomId() -> String {
        var id = String((0 ..< 9).map{ _ in idElement.randomElement()! })
        id.insert("-", at: id.index(id.startIndex, offsetBy: 3))
        id.insert("-", at: id.index(id.startIndex, offsetBy: 7))
        return id
    }
}
