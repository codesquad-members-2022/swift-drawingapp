import Foundation

class SquareFactory {
    let idElement: String = "abcdefghijklmnopqrstuvwxyz0123456789"

    func createSquare(size: Size, point: Point, r: Int, g: Int, b: Int, a: Int) -> Square {
        return Square(id: getRandomId(), size: size, point: point, r: r, g: g, b: b, alpha: a)
    }
    
    func getRandomId() -> String {
        var id = String((0 ..< 9).map{ _ in idElement.randomElement()! })
        id.insert("-", at: id.index(id.startIndex, offsetBy: 3))
        id.insert("-", at: id.index(id.startIndex, offsetBy: 7))
        return id
    }
}
