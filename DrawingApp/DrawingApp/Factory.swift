import Foundation

struct Factory {
    static func createRandomRectangle() -> Rectangle {
        var  id: String {               // UUID: xxx-xxx-xxx
            var uuid = UUID().uuidString.split(separator: "-").map{String($0)}
            uuid.removeFirst()
            uuid.removeLast()
            var resultArray: [String] = []
            for cell in uuid {
                var temp = cell
                temp.removeLast()
                resultArray.append(temp)
            }
            return resultArray.joined(separator: "-")
        }
        let size = Rectangle.Size()
        let point : Rectangle.Point = Rectangle.Point()
        let color : Rectangle.BackgroundColor = Rectangle.BackgroundColor()
        let alpha : Rectangle.Alpha = .random()
        return Rectangle(id: id, point: point, size: size, color: color, alpha: alpha)
    }
}
